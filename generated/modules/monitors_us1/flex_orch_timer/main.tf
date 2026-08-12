# Reverse-engineered branch module.

module "flex_orchestrator_SQS_consumer_error" {
  source = "./flex_orchestrator_SQS_consumer_error"

  tags        = var.tags
  environment = var.environment
}

module "flex_orchestrator_SQS_consumers_p99_latency" {
  source = "./flex_orchestrator_SQS_consumers_p99_latency"

  tags        = var.tags
  environment = var.environment
}

module "flex_orchestrator_SQS_scheduler_p99_latency" {
  source = "./flex_orchestrator_SQS_scheduler_p99_latency"

  tags        = var.tags
  environment = var.environment
}

module "flex_orchestrator_low_create_timers_traffic" {
  source = "./flex_orchestrator_low_create_timers_traffic"

  tags        = var.tags
  environment = var.environment
}

module "flex_orchestrator_low_messages_processed_by_timer" {
  source = "./flex_orchestrator_low_messages_processed_by_timer"

  tags        = var.tags
  environment = var.environment
}

module "flex_orchestrator_participant_init_state_timeouts" {
  source = "./flex_orchestrator_participant_init_state_timeouts"

  tags        = var.tags
  environment = var.environment
}

module "flex_orchestrator_participant_init_timer_cancellation_failed" {
  source = "./flex_orchestrator_participant_init_timer_cancellation_failed"

  tags        = var.tags
  environment = var.environment
}

module "flex_orchestrator_participant_init_timer_creation_failed" {
  source = "./flex_orchestrator_participant_init_timer_creation_failed"

  tags        = var.tags
  environment = var.environment
}

module "flex_orchestrator_participant_init_timer_processor_error" {
  source = "./flex_orchestrator_participant_init_timer_processor_error"

  tags        = var.tags
  environment = var.environment
}

module "flex_orchestrator_timer_processing_p99_latency" {
  source = "./flex_orchestrator_timer_processing_p99_latency"

  tags        = var.tags
  environment = var.environment
}
