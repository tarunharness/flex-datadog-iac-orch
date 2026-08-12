output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.dashboards.module.dashboards_flex_orchestrator_load_test.datadog_dashboard.flex_orchestrator_load_test" = terraform_data.dashboard_flex_orchestrator_load_test.input.datadog_id
  }
}
