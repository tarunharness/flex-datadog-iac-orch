# Reverse-engineered branch module.

module "downstream_response_failures" {
  source = "./downstream_response_failures"

  tags        = var.tags
  environment = var.environment
}

module "high_latency_in_voc" {
  source = "./high_latency_in_voc"

  tags        = var.tags
  environment = var.environment
}

module "host_basics" {
  source = "./host_basics"

  tags        = var.tags
  environment = var.environment
}

module "low_success_rate_in_voc" {
  source = "./low_success_rate_in_voc"

  tags        = var.tags
  environment = var.environment
}
