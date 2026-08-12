output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.dashboards.module.dashboards_flex_orchestrator_flex_orch_timer.datadog_dashboard.flex_orch_timer" = terraform_data.dashboard_flex_orch_timer.input.datadog_id
  }
}
