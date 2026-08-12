output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.monitors_stage-us1.module.flex_interactions_api.module.flex_interactions_low_success_rate_monitor.datadog_monitor.monitor_name[0]" = terraform_data.monitor_monitor_name_0.input.datadog_id
  }
}
