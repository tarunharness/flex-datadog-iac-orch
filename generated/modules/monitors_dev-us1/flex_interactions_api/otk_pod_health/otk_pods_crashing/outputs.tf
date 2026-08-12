output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.monitors_dev-us1.module.flex_interactions_api.module.otk_pod_health.module.otk_pods_crashing.datadog_monitor.monitor_name" = terraform_data.monitor_monitor_name.input.datadog_id
  }
}
