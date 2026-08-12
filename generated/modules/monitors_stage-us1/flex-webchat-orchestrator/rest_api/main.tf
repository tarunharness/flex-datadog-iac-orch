# Reverse-engineered branch module.

module "percentile_latency_99th" {
  source = "./percentile_latency_99th"

  tags        = var.tags
  environment = var.environment
}

module "response_5xx" {
  source = "./response_5xx"

  tags        = var.tags
  environment = var.environment
}

module "success_rate" {
  source = "./success_rate"

  tags        = var.tags
  environment = var.environment
}
