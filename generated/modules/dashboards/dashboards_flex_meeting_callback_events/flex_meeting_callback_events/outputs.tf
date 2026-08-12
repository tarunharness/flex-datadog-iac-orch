output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.dashboards.module.dashboards_flex_meeting_callback_events.module.flex_meeting_callback_events.datadog_dashboard.dashboard_name" = terraform_data.dashboard_dashboard_name.input.datadog_id
  }
}
