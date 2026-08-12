output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.dashboards.module.dashboards_fo_fia_dual_read_write_migration.datadog_dashboard.fo_fia_dual_read_write_migration" = terraform_data.dashboard_fo_fia_dual_read_write_migration.input.datadog_id
  }
}
