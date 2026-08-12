# Reverse-engineered branch module.

module "flex_orch_timer" {
  source = "./flex_orch_timer"

  tags        = var.tags
  environment = var.environment
}

module "voice_orchestrator" {
  source = "./voice_orchestrator"

  tags        = var.tags
  environment = var.environment
}
