# Reverse-engineered branch module.

module "Envoy_CB_client_connection_overflow_monitor" {
  source = "./Envoy_CB_client_connection_overflow_monitor"

  tags        = var.tags
  environment = var.environment
}

module "Envoy_CB_client_request_overflow_monitor" {
  source = "./Envoy_CB_client_request_overflow_monitor"

  tags        = var.tags
  environment = var.environment
}

module "Envoy_CB_server_connection_overflow_monitor" {
  source = "./Envoy_CB_server_connection_overflow_monitor"

  tags        = var.tags
  environment = var.environment
}

module "Envoy_CB_server_request_overflow_monitor" {
  source = "./Envoy_CB_server_request_overflow_monitor"

  tags        = var.tags
  environment = var.environment
}

module "FO_read_on_propertyStore" {
  source = "./FO_read_on_propertyStore"

  tags        = var.tags
  environment = var.environment
}

module "FO_write_on_propertyStore" {
  source = "./FO_write_on_propertyStore"

  tags        = var.tags
  environment = var.environment
}

module "JVM_thread_count_in_FO_is_high" {
  source = "./JVM_thread_count_in_FO_is_high"

  tags        = var.tags
  environment = var.environment
}

module "conference_event_producer_threadpool_basics" {
  source = "./conference_event_producer_threadpool_basics"

  tags        = var.tags
  environment = var.environment
}

module "conference_events_producer_success_rate" {
  source = "./conference_events_producer_success_rate"

  tags        = var.tags
  environment = var.environment
}

module "conference_events_publish_time_monitor" {
  source = "./conference_events_publish_time_monitor"

  tags        = var.tags
  environment = var.environment
}

module "conference_topic_basics" {
  source = "./conference_topic_basics"

  tags        = var.tags
  environment = var.environment
}

module "downstream_response_failures" {
  source = "./downstream_response_failures"

  tags        = var.tags
  environment = var.environment
}

module "drop_in_2xx_create_meeting" {
  source = "./drop_in_2xx_create_meeting"

  tags        = var.tags
  environment = var.environment
}

module "dw_threadpool_basics" {
  source = "./dw_threadpool_basics"

  tags        = var.tags
  environment = var.environment
}

module "flex_orchestrator_envoy_99th_percentile_latency" {
  source = "./flex_orchestrator_envoy_99th_percentile_latency"

  tags        = var.tags
  environment = var.environment
}

module "host_basics" {
  source = "./host_basics"

  tags        = var.tags
  environment = var.environment
}

module "interaction_events_producer_success_rate" {
  source = "./interaction_events_producer_success_rate"

  tags        = var.tags
  environment = var.environment
}

module "interaction_events_publish_time_monitor" {
  source = "./interaction_events_publish_time_monitor"

  tags        = var.tags
  environment = var.environment
}

module "kafka_consumer_lag_monitor" {
  source = "./kafka_consumer_lag_monitor"

  tags        = var.tags
  environment = var.environment
}

module "kafka_consumer_lag_monitor_channel_events" {
  source = "./kafka_consumer_lag_monitor_channel_events"

  tags        = var.tags
  environment = var.environment
}

module "low_create_meeting_2xx" {
  source = "./low_create_meeting_2xx"

  tags        = var.tags
  environment = var.environment
}

module "low_success_rate" {
  source = "./low_success_rate"

  tags        = var.tags
  environment = var.environment
}

module "orch_consumed_event_age" {
  source = "./orch_consumed_event_age"

  tags        = var.tags
  environment = var.environment
}

module "orch_event_consumer_threadpool_basics" {
  source = "./orch_event_consumer_threadpool_basics"

  tags        = var.tags
  environment = var.environment
}

module "orch_event_processing_time_monitor" {
  source = "./orch_event_processing_time_monitor"

  tags        = var.tags
  environment = var.environment
}

module "orch_events_consumption_rate" {
  source = "./orch_events_consumption_rate"

  tags        = var.tags
  environment = var.environment
}

module "orch_meeting_failed_high_consumption_per_sec" {
  source = "./orch_meeting_failed_high_consumption_per_sec"

  tags        = var.tags
  environment = var.environment
}

module "orch_participant_add_failed_high_consumption_per_sec" {
  source = "./orch_participant_add_failed_high_consumption_per_sec"

  tags        = var.tags
  environment = var.environment
}

module "orch_participant_remove_failed_high_consumption_per_sec" {
  source = "./orch_participant_remove_failed_high_consumption_per_sec"

  tags        = var.tags
  environment = var.environment
}

module "unifiedorchestration_topic_basics" {
  source = "./unifiedorchestration_topic_basics"

  tags        = var.tags
  environment = var.environment
}

module "wds_event_consumer_threadpool_basics" {
  source = "./wds_event_consumer_threadpool_basics"

  tags        = var.tags
  environment = var.environment
}
