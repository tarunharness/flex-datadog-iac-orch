# Reverse-engineered branch module.

module "dashboards_e2e_tests" {
  source = "./dashboards_e2e_tests"

  tags        = var.tags
  environment = var.environment
}

module "dashboards_flex_interactions_api" {
  source = "./dashboards_flex_interactions_api"

  tags        = var.tags
  environment = var.environment
}

module "dashboards_flex_meeting_callback_events" {
  source = "./dashboards_flex_meeting_callback_events"

  tags        = var.tags
  environment = var.environment
}

module "dashboards_flex_orchestrator" {
  source = "./dashboards_flex_orchestrator"

  tags        = var.tags
  environment = var.environment
}

module "dashboards_flex_orchestrator_flex_orch_timer" {
  source = "./dashboards_flex_orchestrator_flex_orch_timer"

  tags        = var.tags
  environment = var.environment
}

module "dashboards_flex_orchestrator_load_test" {
  source = "./dashboards_flex_orchestrator_load_test"

  tags        = var.tags
  environment = var.environment
}

module "dashboards_flex_webchat_orchestrator" {
  source = "./dashboards_flex_webchat_orchestrator"

  tags        = var.tags
  environment = var.environment
}

module "dashboards_fo_fia_dual_read_write_migration" {
  source = "./dashboards_fo_fia_dual_read_write_migration"

  tags        = var.tags
  environment = var.environment
}

module "dashboards_msg_orchestrator" {
  source = "./dashboards_msg_orchestrator"

  tags        = var.tags
  environment = var.environment
}

module "dashboards_msg_orchestrator_controller" {
  source = "./dashboards_msg_orchestrator_controller"

  tags        = var.tags
  environment = var.environment
}

module "dashboards_voice_orchestrator" {
  source = "./dashboards_voice_orchestrator"

  tags        = var.tags
  environment = var.environment
}

module "dashboards_voice_orchestrator_controller" {
  source = "./dashboards_voice_orchestrator_controller"

  tags        = var.tags
  environment = var.environment
}
