output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.monitors_stage-au1.module.flex_meeting_callback_events.module.failed_interaction_events_consumer_requests_per_sec.datadog_monitor.monitor_name" = terraform_data.monitor_monitor_name.input.datadog_id
  }
}
