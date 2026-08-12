# Reverse-engineered branch module.

module "Envoy_CB_client_connections_overflow" {
  source = "./Envoy_CB_client_connections_overflow"

  tags        = var.tags
  environment = var.environment
}

module "Envoy_CB_client_requests_overflow" {
  source = "./Envoy_CB_client_requests_overflow"

  tags        = var.tags
  environment = var.environment
}

module "Envoy_CB_server_connections_overflow" {
  source = "./Envoy_CB_server_connections_overflow"

  tags        = var.tags
  environment = var.environment
}

module "Envoy_CB_server_requests_overflow" {
  source = "./Envoy_CB_server_requests_overflow"

  tags        = var.tags
  environment = var.environment
}

module "High_Downstream_Latency_for_call-service" {
  source = "./High_Downstream_Latency_for_call-service"

  tags        = var.tags
  environment = var.environment
}

module "High_Downstream_Latency_for_flex-orchestrator" {
  source = "./High_Downstream_Latency_for_flex-orchestrator"

  tags        = var.tags
  environment = var.environment
}

module "High_latency_from_BEA_Client" {
  source = "./High_latency_from_BEA_Client"

  tags        = var.tags
  environment = var.environment
}

module "callback_events_producer_success_rate" {
  source = "./callback_events_producer_success_rate"

  tags        = var.tags
  environment = var.environment
}

module "callback_events_publish_time" {
  source = "./callback_events_publish_time"

  tags        = var.tags
  environment = var.environment
}

module "orchestrator_events_producer_success_rate" {
  source = "./orchestrator_events_producer_success_rate"

  tags        = var.tags
  environment = var.environment
}

module "orchestrator_events_publish_time" {
  source = "./orchestrator_events_publish_time"

  tags        = var.tags
  environment = var.environment
}

module "total_voice_orchestrator_fsm_timeouts" {
  source = "./total_voice_orchestrator_fsm_timeouts"

  tags        = var.tags
  environment = var.environment
}
