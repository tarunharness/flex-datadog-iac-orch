PLAN_LOG ?= artifacts/plan.log
INVENTORY ?= inventory/plan_refresh_resources.json

# Plan-size tuning (see scripts/generate_from_plan_logs.py). Defaults target ~200MB.
PADDING_CHUNKS ?= 4
PADDING_CHUNK_BYTES ?= 31955
export PADDING_CHUNKS
export PADDING_CHUNK_BYTES

.PHONY: extract generate regen fmt validate plan plan-size

extract:
	python3 scripts/extract_inventory.py $(PLAN_LOG) -o $(INVENTORY)

generate:
	python3 scripts/generate_from_plan_logs.py

regen: extract generate fmt

fmt:
	terraform fmt -recursive generated

plan:
	cd generated && terraform init -input=false
	cd generated && terraform plan -out=tfplan -input=false

validate:
	cd generated && terraform init -input=false
	cd generated && terraform validate

# Regenerate, plan, and report the resulting plan-file size.
plan-size: generate
	cd generated && terraform init -input=false >/dev/null
	cd generated && terraform plan -out=tfplan -input=false >/dev/null
	@bytes=$$(wc -c < generated/tfplan); \
		python3 -c "print(f'tfplan: {$$bytes} bytes = {$$bytes/1048576:.2f} MB')"
