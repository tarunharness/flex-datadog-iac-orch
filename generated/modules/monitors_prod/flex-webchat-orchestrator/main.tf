# Reverse-engineered branch module.

module "api_5xx_monitor" {
  source = "./api_5xx_monitor"

  tags        = var.tags
  environment = var.environment
}

module "downstream_flex_instance_service_4xx" {
  source = "./downstream_flex_instance_service_4xx"

  tags        = var.tags
  environment = var.environment
}

module "downstream_msg_orchestrator_controller_4xx" {
  source = "./downstream_msg_orchestrator_controller_4xx"

  tags        = var.tags
  environment = var.environment
}

module "downstream_response_failures" {
  source = "./downstream_response_failures"

  tags        = var.tags
  environment = var.environment
}

module "dw_threadpool_basics" {
  source = "./dw_threadpool_basics"

  tags        = var.tags
  environment = var.environment
}

module "host_basics" {
  source = "./host_basics"

  tags        = var.tags
  environment = var.environment
}

module "otk_pod_health_0" {
  source = "./otk_pod_health_0"

  tags        = var.tags
  environment = var.environment
}

module "rest_api" {
  source = "./rest_api"

  tags        = var.tags
  environment = var.environment
}
