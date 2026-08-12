# Reverse-engineered branch module.

module "otk_cpu_limit_utilization_high" {
  source = "./otk_cpu_limit_utilization_high"

  tags        = var.tags
  environment = var.environment
}

module "otk_error_rate_high" {
  source = "./otk_error_rate_high"

  tags        = var.tags
  environment = var.environment
}

module "otk_memory_limit_utilization_high" {
  source = "./otk_memory_limit_utilization_high"

  tags        = var.tags
  environment = var.environment
}

module "otk_pod_count_low" {
  source = "./otk_pod_count_low"

  tags        = var.tags
  environment = var.environment
}

module "otk_pods_crashing" {
  source = "./otk_pods_crashing"

  tags        = var.tags
  environment = var.environment
}
