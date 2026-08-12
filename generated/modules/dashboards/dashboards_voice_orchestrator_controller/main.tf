# Reverse-engineered branch module.

module "voice_orchestrator_controller" {
  source = "./voice_orchestrator_controller"

  tags        = var.tags
  environment = var.environment
}
