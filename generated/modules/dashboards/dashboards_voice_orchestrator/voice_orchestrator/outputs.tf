output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.dashboards.module.dashboards_voice_orchestrator.module.voice_orchestrator.datadog_dashboard.dashboard_name" = terraform_data.dashboard_dashboard_name.input.datadog_id
  }
}
