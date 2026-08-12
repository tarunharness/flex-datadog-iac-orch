output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.monitors_prod.module.flex-webchat-orchestrator.module.otk_pod_health[0].module.otk_pods_crashing.datadog_monitor.monitor_name" = terraform_data.monitor_monitor_name.input.datadog_id
  }
}
