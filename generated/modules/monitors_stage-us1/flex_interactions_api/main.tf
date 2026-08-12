# Reverse-engineered branch module.

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

module "flex_interactions_low_success_rate_monitor" {
  source = "./flex_interactions_low_success_rate_monitor"

  tags        = var.tags
  environment = var.environment
}

module "flex_interactions_p99_latency_monitor" {
  source = "./flex_interactions_p99_latency_monitor"

  tags        = var.tags
  environment = var.environment
}

module "host_basics" {
  source = "./host_basics"

  tags        = var.tags
  environment = var.environment
}

module "interaction_topic_basics" {
  source = "./interaction_topic_basics"

  tags        = var.tags
  environment = var.environment
}

module "kafka_consumer_lag_monitor" {
  source = "./kafka_consumer_lag_monitor"

  tags        = var.tags
  environment = var.environment
}

module "kafka_producer_errorRate_monitor" {
  source = "./kafka_producer_errorRate_monitor"

  tags        = var.tags
  environment = var.environment
}

module "otk_pod_health" {
  source = "./otk_pod_health"

  tags        = var.tags
  environment = var.environment
}

module "redis_monitoring" {
  source = "./redis_monitoring"

  tags        = var.tags
  environment = var.environment
}

module "topic_topic_basics" {
  source = "./topic_topic_basics"

  tags        = var.tags
  environment = var.environment
}
