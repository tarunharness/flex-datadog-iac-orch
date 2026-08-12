# Reverse-engineered branch module.

module "Downstream_low_response_success_rate" {
  source = "./Downstream_low_response_success_rate"

  tags        = var.tags
  environment = var.environment
}

module "FSM_errors" {
  source = "./FSM_errors"

  tags        = var.tags
  environment = var.environment
}

module "FSM_timeouts_rate" {
  source = "./FSM_timeouts_rate"

  tags        = var.tags
  environment = var.environment
}

module "HZ_Partition_Lost_Event" {
  source = "./HZ_Partition_Lost_Event"

  tags        = var.tags
  environment = var.environment
}

module "HZ_more_nodes_in_LB_then_in_the_cluster" {
  source = "./HZ_more_nodes_in_LB_then_in_the_cluster"

  tags        = var.tags
  environment = var.environment
}

module "HZ_more_nodes_in_the_cluster_than_in_LB" {
  source = "./HZ_more_nodes_in_the_cluster_than_in_LB"

  tags        = var.tags
  environment = var.environment
}

module "High_99th_percentile_latency" {
  source = "./High_99th_percentile_latency"

  tags        = var.tags
  environment = var.environment
}

module "High_Disk_usage" {
  source = "./High_Disk_usage"

  tags        = var.tags
  environment = var.environment
}

module "High_meeting_fail_transition" {
  source = "./High_meeting_fail_transition"

  tags        = var.tags
  environment = var.environment
}

module "Kafka_Write_Failure" {
  source = "./Kafka_Write_Failure"

  tags        = var.tags
  environment = var.environment
}

module "Memory_usage" {
  source = "./Memory_usage"

  tags        = var.tags
  environment = var.environment
}

module "Number_of_actors_per_node_is_high" {
  source = "./Number_of_actors_per_node_is_high"

  tags        = var.tags
  environment = var.environment
}

module "Tasks_in_queue_is_high" {
  source = "./Tasks_in_queue_is_high"

  tags        = var.tags
  environment = var.environment
}

module "draining_cluster_invalid_routing" {
  source = "./draining_cluster_invalid_routing"

  tags        = var.tags
  environment = var.environment
}

module "host_basics" {
  source = "./host_basics"

  tags        = var.tags
  environment = var.environment
}

module "voice-orchestrator_5xx_per_minute" {
  source = "./voice-orchestrator_5xx_per_minute"

  tags        = var.tags
  environment = var.environment
}

module "voice-orchestrator_JVM_threads_usage" {
  source = "./voice-orchestrator_JVM_threads_usage"

  tags        = var.tags
  environment = var.environment
}

module "voice-orchestrator_success_rate_per_minute_for_staticproxy" {
  source = "./voice-orchestrator_success_rate_per_minute_for_staticproxy"

  tags        = var.tags
  environment = var.environment
}

module "voice-orchestrator_success_rate_per_minute_for_twilioproxy" {
  source = "./voice-orchestrator_success_rate_per_minute_for_twilioproxy"

  tags        = var.tags
  environment = var.environment
}
