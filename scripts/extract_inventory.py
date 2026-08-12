#!/usr/bin/env python3
"""Extract Datadog resource inventory from Harness IaCM / OpenTofu JSON plan logs."""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path

REFRESH_RE = re.compile(
    r"^(.+): Refreshing state\.\.\. \[id=([^\]]+)\]\s*$",
    re.MULTILINE,
)


def module_label(name: str) -> str:
    match = re.match(r"^(.+)\[(\d+)\]$", name)
    if match:
        return f"{match.group(1)}_{match.group(2)}"
    return name


def parse_addr(addr: str) -> dict:
    parts = addr.split(".")
    modules: list[str] = []
    resource_type = None
    resource_name = None
    idx = None
    j = 0
    while j < len(parts):
        if parts[j] == "module":
            modules.append(module_label(parts[j + 1]))
            j += 2
            continue
        if parts[j].startswith("datadog_"):
            resource_type = parts[j]
            resource_name = parts[j + 1]
            j += 2
            break
        j += 1

    base = resource_name or "unknown"
    m = re.match(r"^(.+)\[(\d+)\]$", base)
    if m:
        base = m.group(1)
        idx = int(m.group(2))

    return {
        "address": addr,
        "id": None,
        "modules": modules,
        "type": resource_type,
        "name": base,
        "index": idx,
    }


def extract_from_log(path: Path) -> list[dict]:
    outputs: list[str] = []
    for line in path.read_text().splitlines():
        try:
            payload = json.loads(line)
        except json.JSONDecodeError:
            continue
        out = payload.get("out")
        if out:
            outputs.append(out)

    inventory: list[dict] = []
    seen: set[str] = set()
    for blob in outputs:
        for match in REFRESH_RE.finditer(blob):
            address = match.group(1).strip()
            if address in seen:
                continue
            seen.add(address)
            item = parse_addr(address)
            item["id"] = match.group(2)
            inventory.append(item)

    return inventory


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "plan_log",
        type=Path,
        help="Path to the JSONL Harness/OpenTofu plan log file",
    )
    parser.add_argument(
        "-o",
        "--output",
        type=Path,
        default=Path("inventory/plan_refresh_resources.json"),
        help="Output inventory JSON path",
    )
    args = parser.parse_args()

    inventory = extract_from_log(args.plan_log)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(inventory, indent=2))
    print(f"Wrote {len(inventory)} resources to {args.output}")


if __name__ == "__main__":
    main()
