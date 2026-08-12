output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.dashboards.module.dashboards_voice_orchestrator_controller.module.voice_orchestrator_controller.datadog_dashboard.dashboard_name" = terraform_data.dashboard_dashboard_name.input.datadog_id
  }
}
