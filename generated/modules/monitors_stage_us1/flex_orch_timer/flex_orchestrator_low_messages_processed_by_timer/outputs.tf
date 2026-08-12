output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.monitors_stage_us1.module.flex_orch_timer.module.flex_orchestrator_low_messages_processed_by_timer.datadog_monitor.monitor_name" = terraform_data.monitor_monitor_name.input.datadog_id
  }
}
