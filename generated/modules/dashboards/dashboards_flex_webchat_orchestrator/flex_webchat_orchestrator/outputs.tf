output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.dashboards.module.dashboards_flex_webchat_orchestrator.module.flex_webchat_orchestrator.datadog_dashboard.dashboard_name" = terraform_data.dashboard_dashboard_name.input.datadog_id
  }
}
