#!/usr/bin/env python3
"""Generate Terraform module tree from Harness/OpenTofu plan log inventory.

Uses built-in terraform_data resources so `terraform plan` works with no
Datadog API credentials.
"""

from __future__ import annotations

import base64
import json
import os
import re
import shutil
from collections import defaultdict
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
INVENTORY = REPO / "inventory" / "plan_refresh_resources.json"
GENERATED = REPO / "generated"

# Size inflation controls.
#
# The `tfplan` file is compressed msgpack, so only high-entropy (incompressible)
# data reliably grows it. Each resource embeds `PADDING_CHUNKS` attributes, each
# holding `PADDING_CHUNK_BYTES` of base64-encoded random data. Override via env
# vars PADDING_CHUNKS / PADDING_CHUNK_BYTES to retune the target plan size.
# Defaults calibrated so a full generate + `terraform plan` produces a ~100MB
# tfplan file (810 resources * 4 * 15850 bytes of random data).
PADDING_CHUNKS = int(os.environ.get("PADDING_CHUNKS", "4"))
PADDING_CHUNK_BYTES = int(os.environ.get("PADDING_CHUNK_BYTES", "23891"))


def random_payload(num_bytes: int) -> str:
    """Return base64 text of `num_bytes` random bytes (near-incompressible)."""
    return base64.b64encode(os.urandom(num_bytes)).decode("ascii")


def sanitize(name: str) -> str:
    return re.sub(r"[^a-zA-Z0-9_-]", "_", name)


def tf_quote(value: str) -> str:
    return json.dumps(value)


def module_label(name: str) -> str:
    match = re.match(r"^(.+)\[(\d+)\]$", name)
    if match:
        return f"{match.group(1)}_{match.group(2)}"
    return name


def resource_label(resource: dict) -> str:
    # Prefix keeps unique labels when different original types share a name.
    kind = "monitor" if resource["type"] == "datadog_monitor" else "dashboard"
    base = resource["name"]
    if resource["index"] is not None:
        base = f"{base}_{resource['index']}"
    return f"{kind}_{base}"


class TreeNode:
    __slots__ = ("children", "resources")

    def __init__(self) -> None:
        self.children: dict[str, TreeNode] = defaultdict(TreeNode)
        self.resources: list[dict] = []


def build_tree(items: list[dict]) -> TreeNode:
    root = TreeNode()
    for item in items:
        node = root
        for mod in item["modules"]:
            node = node.children[module_label(mod)]
        node.resources.append(item)
    return root


def write_module_meta(module_dir: Path) -> None:
    module_dir.mkdir(parents=True, exist_ok=True)
    (module_dir / "versions.tf").write_text(
        "\n".join(
            [
                "terraform {",
                "  # terraform_data requires Terraform/OpenTofu 1.4+.",
                "  required_version = \">= 1.4.0\"",
                "}",
                "",
            ]
        )
    )
    (module_dir / "variables.tf").write_text(
        "\n".join(
            [
                "variable \"tags\" {",
                "  type    = list(string)",
                "  default = []",
                "}",
                "",
                "variable \"environment\" {",
                "  type    = string",
                "  default = \"unknown\"",
                "}",
                "",
            ]
        )
    )


def render_resource_block(resource: dict) -> list[str]:
    label = resource_label(resource)
    lines = [
        f"# Original address: {resource['address']}",
        f"# Original type: {resource['type']}",
        f"# Datadog ID: {resource['id']}",
        f"resource \"terraform_data\" \"{label}\" {{",
        "  input = {",
        f"    original_address = {tf_quote(resource['address'])}",
        f"    original_type    = {tf_quote(resource['type'])}",
        f"    datadog_id       = {tf_quote(resource['id'])}",
        "    environment      = var.environment",
        "    tags             = var.tags",
    ]
    # Incompressible padding to inflate the compressed plan file toward the
    # configured target size. Regenerating produces fresh random data each run.
    for chunk in range(PADDING_CHUNKS):
        lines.append(
            f"    padding_{chunk:02d} = {tf_quote(random_payload(PADDING_CHUNK_BYTES))}"
        )
    lines.extend(
        [
            "  }",
            "}",
            "",
        ]
    )
    return lines


def render_leaf_module(node: TreeNode, module_dir: Path) -> None:
    write_module_meta(module_dir)
    lines = [
        "# Reverse-engineered leaf module.",
        "# Uses terraform_data so planning works without Datadog credentials.",
        "",
    ]

    for resource in sorted(node.resources, key=lambda r: (r["type"], r["name"], r["index"] or -1)):
        lines.extend(render_resource_block(resource))

    (module_dir / "main.tf").write_text("\n".join(lines))

    output_lines = [
        "output \"resource_ids\" {",
        "  description = \"Original Datadog IDs captured from the plan refresh output.\"",
        "  value = {",
    ]
    for resource in sorted(node.resources, key=lambda r: r["address"]):
        ref = f"terraform_data.{resource_label(resource)}"
        output_lines.append(
            f"    {tf_quote(resource['address'])} = {ref}.input.datadog_id"
        )
    output_lines.extend(["  }", "}", ""])
    (module_dir / "outputs.tf").write_text("\n".join(output_lines))


def render_branch_module(node: TreeNode, module_dir: Path) -> None:
    write_module_meta(module_dir)
    lines = ["# Reverse-engineered branch module.", ""]

    for child_name in sorted(node.children):
        lines.extend(
            [
                f"module \"{child_name}\" {{",
                f"  source = \"./{sanitize(child_name)}\"",
                "",
                "  tags        = var.tags",
                "  environment = var.environment",
                "}",
                "",
            ]
        )

    if node.resources:
        for resource in sorted(node.resources, key=lambda r: r["address"]):
            lines.extend(render_resource_block(resource))

    (module_dir / "main.tf").write_text("\n".join(lines))


def walk_and_render(node: TreeNode, module_dir: Path) -> None:
    if not node.children and node.resources:
        render_leaf_module(node, module_dir)
        return

    render_branch_module(node, module_dir)

    for child_name, child in node.children.items():
        walk_and_render(child, module_dir / sanitize(child_name))


def infer_environment(root_module: str) -> str:
    if root_module.startswith("monitors_"):
        return root_module.removeprefix("monitors_")
    if "prod" in root_module:
        return "prod"
    if "stage" in root_module:
        return "stage"
    if "dev" in root_module:
        return "dev"
    return "shared"


def render_root_main(tree: TreeNode) -> str:
    lines = [
        "# Root composition reverse-engineered from Harness IaCM plan logs.",
        "# Workspace: ws_flex_datadog-iac_flex-orch",
        "# Original working directory: flex_orchestration",
        "# No Datadog provider: resources are terraform_data stubs for offline planning.",
        "",
    ]

    for root_name in sorted(tree.children):
        env = infer_environment(root_name)
        lines.extend(
            [
                f"module \"{root_name}\" {{",
                f"  source = \"./modules/{sanitize(root_name)}\"",
                "",
                "  tags = concat(var.common_tags, [",
                "    \"service:flex-orchestration\",",
                f"    \"env:{env}\",",
                "    \"workspace:ws_flex_datadog-iac_flex-orch\",",
                "  ])",
                "",
                f"  environment = {tf_quote(env)}",
                "}",
                "",
            ]
        )

    return "\n".join(lines)


def main() -> None:
    items = json.loads(INVENTORY.read_text())
    tree = build_tree(items)

    if GENERATED.exists():
        shutil.rmtree(GENERATED)

    modules_root = GENERATED / "modules"
    modules_root.mkdir(parents=True, exist_ok=True)

    for root_name, child in sorted(tree.children.items()):
        walk_and_render(child, modules_root / sanitize(root_name))

    (GENERATED / "main.tf").write_text(render_root_main(tree))
    (GENERATED / "versions.tf").write_text(
        "\n".join(
            [
                "terraform {",
                "  # terraform_data requires Terraform/OpenTofu 1.4+.",
                "  required_version = \">= 1.4.0\"",
                "}",
                "",
            ]
        )
    )
    (GENERATED / "variables.tf").write_text(
        "\n".join(
            [
                "variable \"common_tags\" {",
                "  description = \"Tags recorded on reconstructed resources.\"",
                "  type        = list(string)",
                "  default     = [\"managed_by:terraform\", \"source:plan-log-reverse-engineer\"]",
                "}",
                "",
            ]
        )
    )
    (GENERATED / "outputs.tf").write_text(
        "\n".join(
            [
                "output \"root_modules\" {",
                "  description = \"Top-level module names reconstructed from the plan log.\"",
                "  value = [",
            ]
            + [f"    {tf_quote(name)}," for name in sorted(tree.children)]
            + [
                "  ]",
                "}",
                "",
                "output \"resource_count\" {",
                "  description = \"Total resources observed in the plan refresh output.\"",
                f"  value       = {len(items)}",
                "}",
                "",
            ]
        )
    )

    summary = {
        "workspace": "ws_flex_datadog-iac_flex-orch",
        "working_directory": "flex_orchestration",
        "plan_result": "no_changes",
        "resource_count": len(items),
        "resource_types": {},
        "root_modules": sorted(tree.children),
        "runtime": "terraform_data stubs (no Datadog provider)",
    }
    for item in items:
        summary["resource_types"][item["type"]] = (
            summary["resource_types"].get(item["type"], 0) + 1
        )
    (REPO / "inventory" / "summary.json").write_text(json.dumps(summary, indent=2))

    print(f"Generated Terraform under {GENERATED}")
    print(f"Root modules: {len(tree.children)}")
    print(f"Resources: {len(items)}")


if __name__ == "__main__":
    main()
