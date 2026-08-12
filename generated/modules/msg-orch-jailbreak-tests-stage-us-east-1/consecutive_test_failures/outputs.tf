output "resource_ids" {
  description = "Original Datadog IDs captured from the plan refresh output."
  value = {
    "module.msg-orch-jailbreak-tests-stage-us-east-1.module.consecutive_test_failures.datadog_monitor.monitor_name" = terraform_data.monitor_monitor_name.input.datadog_id
  }
}
