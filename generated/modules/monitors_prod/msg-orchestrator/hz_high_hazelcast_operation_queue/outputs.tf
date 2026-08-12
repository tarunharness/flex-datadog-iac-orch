output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.monitors_prod.module.msg-orchestrator.module.hz_high_hazelcast_operation_queue.datadog_monitor.monitor_name[0]" = terraform_data.monitor_monitor_name_0.input.datadog_id
  }
}
