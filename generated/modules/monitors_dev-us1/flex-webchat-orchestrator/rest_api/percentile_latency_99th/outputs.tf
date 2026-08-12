output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.monitors_dev-us1.module.flex-webchat-orchestrator.module.rest_api.module.percentile_latency_99th.datadog_monitor.monitor_name[0]" = terraform_data.monitor_monitor_name_0.input.datadog_id
  }
}
