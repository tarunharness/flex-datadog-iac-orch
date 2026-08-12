output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.monitors_stage-us1.module.flex_orchestrator.module.orch_participant_remove_failed_high_consumption_per_sec.datadog_monitor.monitor_name" = terraform_data.monitor_monitor_name.input.datadog_id
  }
}
