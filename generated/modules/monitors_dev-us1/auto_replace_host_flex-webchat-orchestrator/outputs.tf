output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.monitors_dev-us1.module.auto_replace_host_flex-webchat-orchestrator.datadog_monitor.auto_replace_host" = terraform_data.monitor_auto_replace_host.input.datadog_id
  }
}
