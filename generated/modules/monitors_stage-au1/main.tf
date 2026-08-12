# Reverse-engineered branch module.

module "flex_meeting_callback_events" {
  source = "./flex_meeting_callback_events"

  tags        = var.tags
  environment = var.environment
}

module "flex_orchestrator" {
  source = "./flex_orchestrator"

  tags        = var.tags
  environment = var.environment
}

module "voice_orchestrator" {
  source = "./voice_orchestrator"

  tags        = var.tags
  environment = var.environment
}
