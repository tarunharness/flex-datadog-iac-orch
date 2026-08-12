# Reverse-engineered branch module.

module "no_test_runs_e2etester_taskrouter" {
  source = "./no_test_runs_e2etester_taskrouter"

  tags        = var.tags
  environment = var.environment
}

module "no_test_runs_e2etester_taskrouter_fo_inbound" {
  source = "./no_test_runs_e2etester_taskrouter_fo_inbound"

  tags        = var.tags
  environment = var.environment
}
