output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.monitors_stage-au1.module.voice_orchestrator.module.voice-orchestrator_success_rate_per_minute_for_staticproxy.datadog_monitor.monitor_name" = terraform_data.monitor_monitor_name.input.datadog_id
  }
}
