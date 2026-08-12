output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.monitors_ie1.module.flex_meeting_callback_events.module.host_basics.module.used_file_handles.datadog_monitor.monitor_name" = terraform_data.monitor_monitor_name.input.datadog_id
  }
}
