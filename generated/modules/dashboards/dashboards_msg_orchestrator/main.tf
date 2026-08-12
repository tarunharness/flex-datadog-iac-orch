# Reverse-engineered branch module.

module "msg_orchestrator" {
  source = "./msg_orchestrator"

  tags        = var.tags
  environment = var.environment
}
