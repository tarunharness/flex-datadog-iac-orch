# Reverse-engineered branch module.

module "downstream_conversations_api_failure" {
  source = "./downstream_conversations_api_failure"

  tags        = var.tags
  environment = var.environment
}

module "downstream_response_failures" {
  source = "./downstream_response_failures"

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

module "hz_high_actor_count" {
  source = "./hz_high_actor_count"

  tags        = var.tags
  environment = var.environment
}

module "hz_high_hazelcast_operation_queue" {
  source = "./hz_high_hazelcast_operation_queue"

  tags        = var.tags
  environment = var.environment
}

module "hz_more_nodes_in_the_cluster_than_in_lb" {
  source = "./hz_more_nodes_in_the_cluster_than_in_lb"

  tags        = var.tags
  environment = var.environment
}

module "hz_partition_lost_event" {
  source = "./hz_partition_lost_event"

  tags        = var.tags
  environment = var.environment
}

module "kafka_publish_failures" {
  source = "./kafka_publish_failures"

  tags        = var.tags
  environment = var.environment
}

module "orchestration_event_failures" {
  source = "./orchestration_event_failures"

  tags        = var.tags
  environment = var.environment
}

module "publish_time_p99_monitor" {
  source = "./publish_time_p99_monitor"

  tags        = var.tags
  environment = var.environment
}

module "rate_limit_exceeded_requests" {
  source = "./rate_limit_exceeded_requests"

  tags        = var.tags
  environment = var.environment
}

module "rest_api" {
  source = "./rest_api"

  tags        = var.tags
  environment = var.environment
}
