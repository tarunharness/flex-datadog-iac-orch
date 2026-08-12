# flex-datadog-iac-orch-20mb

Reverse-engineered OpenTofu/Terraform layout for the Harness IaCM workspace **`ws_flex_datadog-iac_flex-orch`**, reconstructed from a plan-step log export.

This variant extends the base reconstruction to emit a **~20MB `terraform plan` file**. The base repo (`flex-datadog-iac-orch`) produces a ~1.7MB plan; here each resource carries tunable incompressible padding so the compressed plan reaches ~20MB. See [Controlling plan-file size](#controlling-plan-file-size).

## What this repo contains

The source artifact is a JSONL plan log (`artifacts/plan.log`) from a Harness pipeline run against the original **`flex_orchestration`** working directory. The log shows:

- **810 managed Datadog resources** refreshed during plan
  - 798 `datadog_monitor`
  - 12 `datadog_dashboard`
- **33 root modules** (dashboards, per-environment monitor stacks, OTK health checks, cluster/e2e test monitors)
- Plan result: **No changes** (infrastructure matched configuration)

Because only plan logs were available—not the original `.tf` sources or the ~40MB binary plan—the generated code captures:

1. The exact module/resource address tree from refresh output
2. Original Datadog IDs as comments and inventory metadata
3. Placeholder monitor/dashboard bodies safe for scaffolding and import workflows

## Layout

```text
artifacts/plan.log                 # Source Harness/OpenTofu JSONL log
inventory/
  plan_refresh_resources.json      # Parsed refresh inventory
  summary.json                     # High-level counts
scripts/
  extract_inventory.py             # Parse plan log -> inventory JSON
  generate_from_plan_logs.py       # Inventory JSON -> Terraform modules
generated/                         # Generated Terraform root (run plan/apply here)
  main.tf
  modules/                         # Nested module tree mirroring original addresses
```

## Regenerate from the plan log

```bash
make regen
```

Or step-by-step:

```bash
python3 scripts/extract_inventory.py artifacts/plan.log
python3 scripts/generate_from_plan_logs.py
terraform fmt -recursive generated
```

## Plan / validate locally (no Datadog keys)

Generated resources are `terraform_data` stubs that preserve the original
module addresses and Datadog IDs as metadata. No provider credentials needed.

```bash
make plan
# or:
cd generated && terraform init && terraform plan
```

## Controlling plan-file size

The `tfplan` file is compressed msgpack, so only high-entropy data reliably
grows it. Each generated `terraform_data` resource embeds
`PADDING_CHUNKS` attributes of `PADDING_CHUNK_BYTES` random base64 bytes.

Defaults (`4` chunks x `2950` bytes across 810 resources) yield a **~20MB** plan
file. Regenerate and report the exact size with:

```bash
make plan-size
# tfplan: 21111170 bytes = 20.13 MB
```

Retune for a different target by overriding the knobs (roughly:
`plan_MB ≈ 1.7 + 810 * PADDING_CHUNKS * PADDING_CHUNK_BYTES * 2.12 / 1048576`):

```bash
# ~40MB
PADDING_CHUNK_BYTES=5950 make plan-size

# back to the ~1.7MB baseline (no padding)
PADDING_CHUNKS=0 make plan-size
```

The knobs are read as environment variables by both the generator and the
Makefile, so `PADDING_CHUNKS` / `PADDING_CHUNK_BYTES` work in either place.

## Root modules reconstructed

| Module | Role |
| --- | --- |
| `dashboards` | Flex orchestration Datadog dashboards |
| `monitors_dev-us1` / `monitors_stage-us1` / `monitors_prod` | Full service monitor stacks |
| `monitors_ie1` / `monitors_stage-au1` | Regional monitor subsets |
| `monitors_stage_us1` / `monitors_us1` | Timer/voice-focused monitor subsets |
| `monitors_stage_only` / `monitors_prod_only` | Environment-specific test monitors |
| `otk_*` | OTK pod health monitor wrappers |
| `*-cluster-tests-*` / `orch-e2e-*` | Synthetic test failure / missing-run monitors |

See `inventory/summary.json` for exact counts.

## Important limitations

- This repo does **not** call the Datadog API. Resources are offline `terraform_data` stubs.
- Monitor queries, thresholds, notification targets, and dashboard widgets are **not** recoverable from the plan log refresh lines.
- Resource labels that used `count` in the original code appear as suffixed names like `monitor_name_0`.
- To manage real Datadog objects again, reintroduce the Datadog provider and convert stubs back to `datadog_monitor` / `datadog_dashboard` using IDs in `inventory/plan_refresh_resources.json`.

## Original pipeline context

From the log header:

- IaCM plugin: `0.277.0`
- Provisioner: OpenTofu
- Command: `tofu plan -no-color -input=false -detailed-exitcode -lock-timeout=0s -out=plan.out -lock=true -parallelism=10 -refresh=true`
- Human-readable plan artifact size: ~40MB (not included in this export)
