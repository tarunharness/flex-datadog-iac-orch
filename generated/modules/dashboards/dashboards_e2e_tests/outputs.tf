output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.dashboards.module.dashboards_e2e_tests.datadog_dashboard.ordered_dashboard" = terraform_data.dashboard_ordered_dashboard.input.datadog_id
  }
}
