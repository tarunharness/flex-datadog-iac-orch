output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.monitors_dev-us1.module.flex_interactions_api.module.redis_monitoring.module.redis_cpu_utilization_high.datadog_monitor.monitor_name" = terraform_data.monitor_monitor_name.input.datadog_id
  }
}
