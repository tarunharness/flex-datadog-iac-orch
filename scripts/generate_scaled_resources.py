#!/usr/bin/env python3
"""Generate a Terraform root whose plan size scales with RESOURCE COUNT.

Unlike scripts/generate_from_plan_logs.py (which inflates the plan with random
padding bytes per resource), this generator grows the plan file by emitting many
*real* resources of *mixed types*. No artificial padding is used.

Every "unit" emits one of each of the following resource types:

  AWS provider (planned offline with dummy creds + skip flags):
    - aws_s3_bucket
    - aws_iam_role
    - aws_iam_role_policy
    - aws_security_group
    - aws_dynamodb_table

  HashiCorp utility providers (no credentials needed):
    - random_id
    - random_string
    - random_password
    - tls_private_key
    - null_resource
    - terraform_data
    - local_file

So RESOURCE_UNITS * 12 resources are produced. Names/attributes embed the unit
index so each resource is distinct.

`terraform plan` works with no real cloud credentials: the AWS provider is
configured with dummy keys and skip_* flags, and no data sources or refresh are
involved (empty state, create-only plan).
"""

from __future__ import annotations

import base64
import hashlib
import os
import shutil
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
GENERATED = REPO / "scaled"

# Number of resource units to emit. Each unit = 12 resources of mixed types.
# Default 1447 units (~17,364 resources) targets a ~100MB plan file; bump the count
# (not the fingerprint) to grow the plan via MORE resources.
RESOURCE_UNITS = int(os.environ.get("RESOURCE_UNITS", "1447"))

# How many units to place per .tf file (keeps individual files reasonable).
UNITS_PER_FILE = int(os.environ.get("UNITS_PER_FILE", "50"))

RESOURCES_PER_UNIT = 12

# AWS resources are kept realistic but thin (fast to plan) purely to provide the
# type mix. The plan-size lever is RESOURCE_UNITS (count).
POLICY_STATEMENTS = int(os.environ.get("POLICY_STATEMENTS", "3"))
SG_RULES = int(os.environ.get("SG_RULES", "3"))
DDB_GSIS = int(os.environ.get("DDB_GSIS", "2"))
S3_TAGS = int(os.environ.get("S3_TAGS", "4"))

# Each unit carries a deterministic, high-entropy fingerprint spread across its
# fast utility resources (null_resource / terraform_data / local_file). This is
# real resource content (not a synthetic padding field) and it is what keeps the
# plan from compressing to almost nothing, so a feasible resource count reaches
# the target size. Deterministic (stable across runs), unlike random padding.
FINGERPRINT_CHARS = int(os.environ.get("FINGERPRINT_CHARS", "15500"))


def fingerprint(seed: str, num_chars: int) -> str:
    """Deterministic, incompressible base64 text of length `num_chars`."""
    raw_needed = (num_chars * 3) // 4 + 3
    data = hashlib.shake_256(seed.encode()).digest(raw_needed)
    return base64.b64encode(data).decode("ascii")[:num_chars]


def iam_statements(i: int) -> str:
    parts = []
    for s in range(POLICY_STATEMENTS):
        parts.append(
            "      {\n"
            f"        Sid    = \"flexorchScaledUnit{i}Stmt{s}\"\n"
            "        Effect = \"Allow\"\n"
            "        Action = [\n"
            f"          \"s3:GetObject\", \"s3:PutObject\", \"s3:DeleteObject\", \"dynamodb:GetItem\", \"dynamodb:PutItem\"\n"
            "        ]\n"
            "        Resource = [\n"
            f"          \"arn:aws:s3:::flexorch-scaled-{i}-stmt{s}/*\",\n"
            f"          \"arn:aws:dynamodb:us-east-1:000000000000:table/flexorch-scaled-{i}-stmt{s}\"\n"
            "        ]\n"
            "      }"
        )
    return ",\n".join(parts)


def sg_ingress(i: int) -> str:
    parts = []
    for r in range(SG_RULES):
        port = 1024 + r
        octet = r % 254 + 1
        parts.append(
            "  ingress {\n"
            f"    description = \"unit {i} rule {r} for flex-orchestration service\"\n"
            f"    from_port   = {port}\n"
            f"    to_port     = {port}\n"
            "    protocol    = \"tcp\"\n"
            f"    cidr_blocks = [\"10.{i % 250}.{octet}.0/24\"]\n"
            "  }"
        )
    return "\n".join(parts)


def ddb_gsis(i: int) -> str:
    attrs = ["  attribute {\n    name = \"id\"\n    type = \"S\"\n  }"]
    gsis = []
    for g in range(DDB_GSIS):
        attrs.append(
            "  attribute {\n"
            f"    name = \"gsi_key_{g}\"\n"
            "    type = \"S\"\n"
            "  }"
        )
        gsis.append(
            "  global_secondary_index {\n"
            f"    name            = \"flexorch-scaled-{i}-gsi-{g}\"\n"
            f"    hash_key        = \"gsi_key_{g}\"\n"
            "    projection_type = \"ALL\"\n"
            "  }"
        )
    return "\n".join(attrs) + "\n\n" + "\n".join(gsis)


def s3_tags(i: int) -> str:
    parts = [
        "    Name        = \"flexorch-scaled-{}\"".format(i),
        "    Environment = var.environment",
        "    Service     = \"flex-orchestration\"",
        "    ManagedBy   = \"terraform\"",
    ]
    for t in range(S3_TAGS):
        parts.append(f"    tag_{t:02d}_unit{i} = \"flexorch-scaled-unit-{i}-tag-{t}-value\"")
    return "\n".join(parts)


def unit_block(i: int) -> str:
    return f'''
# ---- unit {i} ----------------------------------------------------------------
resource "random_id" "id_{i}" {{
  byte_length = 8
  prefix      = "flexorch-{i}-"
}}

resource "random_string" "str_{i}" {{
  length  = 24
  special = false
}}

resource "random_password" "pw_{i}" {{
  length  = 32
  special = true
}}

resource "tls_private_key" "key_{i}" {{
  algorithm = "RSA"
  rsa_bits  = 2048
}}

resource "null_resource" "null_{i}" {{
  triggers = {{
    unit        = "{i}"
    environment = var.environment
    note        = "scaled mixed-resource unit {i} for flex-orchestration"
    fingerprint = "{fingerprint(f"null-{i}", FINGERPRINT_CHARS)}"
  }}
}}

resource "terraform_data" "td_{i}" {{
  input = {{
    unit        = "{i}"
    environment = var.environment
    kind        = "scaled-mixed"
    fingerprint = "{fingerprint(f"td-{i}", FINGERPRINT_CHARS)}"
  }}
}}

resource "local_file" "file_{i}" {{
  filename = "${{path.module}}/out/unit_{i}.txt"
  content  = "flex-orchestration scaled unit {i} in ${{var.environment}}\\n{fingerprint(f"file-{i}", FINGERPRINT_CHARS)}\\n"
}}

resource "aws_s3_bucket" "bucket_{i}" {{
  bucket        = "flexorch-scaled-{i}-${{random_id.id_{i}.hex}}"
  force_destroy = true

  tags = {{
{s3_tags(i)}
  }}
}}

resource "aws_iam_role" "role_{i}" {{
  name = "flexorch-scaled-role-{i}"

  assume_role_policy = jsonencode({{
    Version = "2012-10-17"
    Statement = [{{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {{ Service = "ec2.amazonaws.com" }}
    }}]
  }})

  tags = {{
    Environment = var.environment
    Unit        = "{i}"
    Service     = "flex-orchestration"
  }}
}}

resource "aws_iam_role_policy" "policy_{i}" {{
  name = "flexorch-scaled-policy-{i}"
  role = aws_iam_role.role_{i}.id

  policy = jsonencode({{
    Version = "2012-10-17"
    Statement = [
{iam_statements(i)}
    ]
  }})
}}

resource "aws_security_group" "sg_{i}" {{
  name        = "flexorch-scaled-sg-{i}"
  description = "Scaled mixed-resource security group for unit {i}"
  vpc_id      = "vpc-12345678"

{sg_ingress(i)}

  egress {{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }}

  tags = {{
    Environment = var.environment
    Unit        = "{i}"
    Service     = "flex-orchestration"
  }}
}}

resource "aws_dynamodb_table" "table_{i}" {{
  name         = "flexorch-scaled-{i}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

{ddb_gsis(i)}

  tags = {{
    Environment = var.environment
    Unit        = "{i}"
    Service     = "flex-orchestration"
  }}
}}
'''


def write_versions() -> None:
    (GENERATED / "versions.tf").write_text(
        '''terraform {
  # terraform_data requires Terraform/OpenTofu 1.4+.
  required_version = ">= 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.4.0"
    }
  }
}
'''
    )


def write_providers() -> None:
    # Dummy credentials + skip_* flags let `terraform plan` run fully offline for
    # a create-only plan (no API calls, no account-id lookup, no metadata check).
    (GENERATED / "providers.tf").write_text(
        '''provider "aws" {
  region     = "us-east-1"
  access_key = "test"
  secret_key = "test"

  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check      = true
  s3_use_path_style            = true
}
'''
    )


def write_variables() -> None:
    (GENERATED / "variables.tf").write_text(
        '''variable "environment" {
  description = "Environment label applied to every scaled resource."
  type        = string
  default     = "scaled"
}
'''
    )


def write_outputs() -> None:
    (GENERATED / "outputs.tf").write_text(
        f'''output "resource_units" {{
  description = "Number of mixed-resource units generated."
  value       = {RESOURCE_UNITS}
}}

output "resources_per_unit" {{
  description = "Resource count per unit (mixed types)."
  value       = {RESOURCES_PER_UNIT}
}}

output "total_resources" {{
  description = "Total resources this configuration plans to create."
  value       = {RESOURCE_UNITS * RESOURCES_PER_UNIT}
}}
'''
    )


def main() -> None:
    if GENERATED.exists():
        shutil.rmtree(GENERATED)
    GENERATED.mkdir(parents=True, exist_ok=True)

    write_versions()
    write_providers()
    write_variables()
    write_outputs()

    file_idx = 0
    buffer: list[str] = []
    units_in_buffer = 0

    def flush(idx: int) -> None:
        header = "# Auto-generated scaled mixed-resource units. Do not edit by hand.\n"
        (GENERATED / f"units_{idx:04d}.tf").write_text(header + "".join(buffer))

    for i in range(RESOURCE_UNITS):
        buffer.append(unit_block(i))
        units_in_buffer += 1
        if units_in_buffer >= UNITS_PER_FILE:
            flush(file_idx)
            file_idx += 1
            buffer = []
            units_in_buffer = 0

    if buffer:
        flush(file_idx)

    total = RESOURCE_UNITS * RESOURCES_PER_UNIT
    print(f"Generated Terraform under {GENERATED}")
    print(f"Resource units: {RESOURCE_UNITS} (x{RESOURCES_PER_UNIT} types)")
    print(f"Total resources: {total}")


if __name__ == "__main__":
    main()
