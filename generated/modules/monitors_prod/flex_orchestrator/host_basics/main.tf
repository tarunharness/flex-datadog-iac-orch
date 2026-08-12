# Reverse-engineered branch module.

module "cpu_consumption" {
  source = "./cpu_consumption"

  tags        = var.tags
  environment = var.environment
}

module "jvm_heap_usage" {
  source = "./jvm_heap_usage"

  tags        = var.tags
  environment = var.environment
}

module "low_disk_space" {
  source = "./low_disk_space"

  tags        = var.tags
  environment = var.environment
}

module "low_memory" {
  source = "./low_memory"

  tags        = var.tags
  environment = var.environment
}

module "system_load" {
  source = "./system_load"

  tags        = var.tags
  environment = var.environment
}

module "used_file_handles" {
  source = "./used_file_handles"

  tags        = var.tags
  environment = var.environment
}
