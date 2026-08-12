# Reverse-engineered branch module.

module "msg_orchestrator_controller" {
  source = "./msg_orchestrator_controller"

  tags        = var.tags
  environment = var.environment
}
