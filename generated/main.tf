# Root composition reverse-engineered from Harness IaCM plan logs.
# Workspace: ws_flex_datadog-iac_flex-orch
# Original working directory: flex_orchestration
# No Datadog provider: resources are terraform_data stubs for offline planning.

module "dashboards" {
  source = "./modules/dashboards"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:shared",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "shared"
}

module "fia-cluster-tests-prod-us-east-1" {
  source = "./modules/fia-cluster-tests-prod-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:prod",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "prod"
}

module "fia-cluster-tests-stage-us-east-1" {
  source = "./modules/fia-cluster-tests-stage-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage"
}

module "flex-orch-cluster-tests-prod-us-east-1" {
  source = "./modules/flex-orch-cluster-tests-prod-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:prod",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "prod"
}

module "flex-orch-cluster-tests-stage-us-east-1" {
  source = "./modules/flex-orch-cluster-tests-stage-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage"
}

module "flex-orch-jailbreak-tests-stage-us-east-1" {
  source = "./modules/flex-orch-jailbreak-tests-stage-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage"
}

module "flex-orch-sixsigma-tests-prod-us-east-1" {
  source = "./modules/flex-orch-sixsigma-tests-prod-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:prod",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "prod"
}

module "flex-orch-sixsigma-tests-stage-us-east-1" {
  source = "./modules/flex-orch-sixsigma-tests-stage-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage"
}

module "flex_channel_janitor_cluster_tests_stage_us_east_1" {
  source = "./modules/flex_channel_janitor_cluster_tests_stage_us_east_1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage"
}

module "flex_channel_orch_cluster_tests_stage_us_east_1" {
  source = "./modules/flex_channel_orch_cluster_tests_stage_us_east_1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage"
}

module "fo-fia-ddb-tests-stage-us-east-1" {
  source = "./modules/fo-fia-ddb-tests-stage-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage"
}

module "moc-cluster-tests-prod-us-east-1" {
  source = "./modules/moc-cluster-tests-prod-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:prod",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "prod"
}

module "moc-cluster-tests-stage-us-east-1" {
  source = "./modules/moc-cluster-tests-stage-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage"
}

module "monitors_dev-us1" {
  source = "./modules/monitors_dev-us1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:dev-us1",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "dev-us1"
}

module "monitors_ie1" {
  source = "./modules/monitors_ie1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:ie1",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "ie1"
}

module "monitors_prod" {
  source = "./modules/monitors_prod"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:prod",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "prod"
}

module "monitors_prod_only" {
  source = "./modules/monitors_prod_only"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:prod_only",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "prod_only"
}

module "monitors_stage-au1" {
  source = "./modules/monitors_stage-au1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage-au1",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage-au1"
}

module "monitors_stage-us1" {
  source = "./modules/monitors_stage-us1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage-us1",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage-us1"
}

module "monitors_stage_only" {
  source = "./modules/monitors_stage_only"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage_only",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage_only"
}

module "monitors_stage_us1" {
  source = "./modules/monitors_stage_us1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage_us1",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage_us1"
}

module "monitors_us1" {
  source = "./modules/monitors_us1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:us1",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "us1"
}

module "msg-orch-cluster-tests-prod-us-east-1" {
  source = "./modules/msg-orch-cluster-tests-prod-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:prod",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "prod"
}

module "msg-orch-cluster-tests-stage-us-east-1" {
  source = "./modules/msg-orch-cluster-tests-stage-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage"
}

module "msg-orch-jailbreak-tests-prod-us-east-1" {
  source = "./modules/msg-orch-jailbreak-tests-prod-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:prod",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "prod"
}

module "msg-orch-jailbreak-tests-stage-us-east-1" {
  source = "./modules/msg-orch-jailbreak-tests-stage-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage"
}

module "msg-orch-sixsigma-tests-stage-us-east-1" {
  source = "./modules/msg-orch-sixsigma-tests-stage-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage"
}

module "orch-e2e-client-otk-tests-stage-us-east-1" {
  source = "./modules/orch-e2e-client-otk-tests-stage-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage"
}

module "orch-e2e-sip-otk-tests-stage-us-east-1" {
  source = "./modules/orch-e2e-sip-otk-tests-stage-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage"
}

module "orch-e2e-voice-otk-tests-prod-eu-west-1" {
  source = "./modules/orch-e2e-voice-otk-tests-prod-eu-west-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:prod",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "prod"
}

module "orch-e2e-voice-otk-tests-prod-us-east-1" {
  source = "./modules/orch-e2e-voice-otk-tests-prod-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:prod",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "prod"
}

module "orch-e2e-voice-otk-tests-stage-au1" {
  source = "./modules/orch-e2e-voice-otk-tests-stage-au1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage"
}

module "orch-e2e-voice-otk-tests-stage-us-east-1" {
  source = "./modules/orch-e2e-voice-otk-tests-stage-us-east-1"

  tags = concat(var.common_tags, [
    "service:flex-orchestration",
    "env:stage",
    "workspace:ws_flex_datadog-iac_flex-orch",
  ])

  environment = "stage"
}
