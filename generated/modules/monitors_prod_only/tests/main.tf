# Reverse-engineered branch module.

module "no_test_runs_e2etester_basictaskrouter" {
  source = "./no_test_runs_e2etester_basictaskrouter"

  tags        = var.tags
  environment = var.environment
}
