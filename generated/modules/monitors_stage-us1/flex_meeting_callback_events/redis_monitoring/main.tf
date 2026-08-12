# Reverse-engineered branch module.

module "redis_connections_high" {
  source = "./redis_connections_high"

  tags        = var.tags
  environment = var.environment
}

module "redis_cpu_utilization_high" {
  source = "./redis_cpu_utilization_high"

  tags        = var.tags
  environment = var.environment
}

module "redis_dispatch_error_rate_high" {
  source = "./redis_dispatch_error_rate_high"

  tags        = var.tags
  environment = var.environment
}

module "redis_memory_utilization_high" {
  source = "./redis_memory_utilization_high"

  tags        = var.tags
  environment = var.environment
}

module "redis_rate_limit_exceeded_high" {
  source = "./redis_rate_limit_exceeded_high"

  tags        = var.tags
  environment = var.environment
}
