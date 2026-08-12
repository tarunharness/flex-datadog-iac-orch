output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.monitors_prod.module.flex-webchat-orchestrator.module.dw_threadpool_basics.module.threadpool_queue_size.datadog_monitor.monitor_name[0]" = terraform_data.monitor_monitor_name_0.input.datadog_id
  }
}
