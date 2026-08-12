output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.monitors_dev-us1.module.voice_orchestrator.module.HZ_more_nodes_in_the_cluster_than_in_LB.datadog_monitor.monitor_name" = terraform_data.monitor_monitor_name.input.datadog_id
  }
}
