# Reverse-engineered branch module.

module "flex_orchestrator" {
  source = "./flex_orchestrator"

  tags        = var.tags
  environment = var.environment
}
