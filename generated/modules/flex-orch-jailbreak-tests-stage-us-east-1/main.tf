# Reverse-engineered branch module.

module "consecutive_test_failures" {
  source = "./consecutive_test_failures"

  tags        = var.tags
  environment = var.environment
}

module "missing_test_runs" {
  source = "./missing_test_runs"

  tags        = var.tags
  environment = var.environment
}
