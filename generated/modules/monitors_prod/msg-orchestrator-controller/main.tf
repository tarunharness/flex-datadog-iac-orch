# Reverse-engineered branch module.

module "downstream_response_failures" {
  source = "./downstream_response_failures"

  tags        = var.tags
  environment = var.environment
}

module "host_basics" {
  source = "./host_basics"

  tags        = var.tags
  environment = var.environment
}

module "low_success_rate" {
  source = "./low_success_rate"

  tags        = var.tags
  environment = var.environment
}

module "rest_api" {
  source = "./rest_api"

  tags        = var.tags
  environment = var.environment
}
