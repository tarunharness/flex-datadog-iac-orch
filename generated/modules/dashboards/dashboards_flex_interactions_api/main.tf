# Reverse-engineered branch module.

module "flex_interactions_api_dashboard" {
  source = "./flex_interactions_api_dashboard"

  tags        = var.tags
  environment = var.environment
}
