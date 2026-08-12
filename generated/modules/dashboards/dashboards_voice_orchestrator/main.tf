# Reverse-engineered branch module.

module "voice_orchestrator" {
  source = "./voice_orchestrator"

  tags        = var.tags
  environment = var.environment
}
