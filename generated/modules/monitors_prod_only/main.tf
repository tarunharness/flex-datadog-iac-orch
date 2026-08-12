# Reverse-engineered branch module.

module "tests" {
  source = "./tests"

  tags        = var.tags
  environment = var.environment
}
