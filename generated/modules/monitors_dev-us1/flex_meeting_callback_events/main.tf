# Reverse-engineered branch module.

module "FMCE_event_processing_failure" {
  source = "./FMCE_event_processing_failure"

  tags        = var.tags
  environment = var.environment
}

module "FMCE_read_on_propertyStore" {
  source = "./FMCE_read_on_propertyStore"

  tags        = var.tags
  environment = var.environment
}

module "callback_event_consumer_threadpool_basics" {
  source = "./callback_event_consumer_threadpool_basics"

  tags        = var.tags
  environment = var.environment
}

module "dw_threadpool_basics" {
  source = "./dw_threadpool_basics"

  tags        = var.tags
  environment = var.environment
}

module "failed_interaction_events_consumer_requests_per_sec" {
  source = "./failed_interaction_events_consumer_requests_per_sec"

  tags        = var.tags
  environment = var.environment
}

module "host_basics" {
  source = "./host_basics"

  tags        = var.tags
  environment = var.environment
}

module "kafka_consumer_lag_monitor" {
  source = "./kafka_consumer_lag_monitor"

  tags        = var.tags
  environment = var.environment
}

module "kafka_interaction_event_consumer_lag_monitor" {
  source = "./kafka_interaction_event_consumer_lag_monitor"

  tags        = var.tags
  environment = var.environment
}

module "kafka_wds_consumer_lag_monitor" {
  source = "./kafka_wds_consumer_lag_monitor"

  tags        = var.tags
  environment = var.environment
}

module "low_success_rate" {
  source = "./low_success_rate"

  tags        = var.tags
  environment = var.environment
}

module "meeting_callback_topic_basics" {
  source = "./meeting_callback_topic_basics"

  tags        = var.tags
  environment = var.environment
}

module "otk_event_processing_failure" {
  source = "./otk_event_processing_failure"

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

module "rest_api" {
  source = "./rest_api"

  tags        = var.tags
  environment = var.environment
}
