# Reverse-engineered branch module.

module "flex_webchat_orchestrator" {
  source = "./flex_webchat_orchestrator"

  tags        = var.tags
  environment = var.environment
}
