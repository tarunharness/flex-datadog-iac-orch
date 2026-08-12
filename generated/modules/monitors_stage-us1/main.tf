# Reverse-engineered branch module.

module "auto_replace_host_flex-webchat-orchestrator" {
  source = "./auto_replace_host_flex-webchat-orchestrator"

  tags        = var.tags
  environment = var.environment
}

module "auto_replace_host_msg-orchestrator-controller" {
  source = "./auto_replace_host_msg-orchestrator-controller"

  tags        = var.tags
  environment = var.environment
}

module "flex-webchat-orchestrator" {
  source = "./flex-webchat-orchestrator"

  tags        = var.tags
  environment = var.environment
}

module "flex_interactions_api" {
  source = "./flex_interactions_api"

  tags        = var.tags
  environment = var.environment
}

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

module "msg-orchestrator" {
  source = "./msg-orchestrator"

  tags        = var.tags
  environment = var.environment
}

module "msg-orchestrator-controller" {
  source = "./msg-orchestrator-controller"

  tags        = var.tags
  environment = var.environment
}

module "voice_orchestrator" {
  source = "./voice_orchestrator"

  tags        = var.tags
  environment = var.environment
}

module "voice_orchestrator_controller" {
  source = "./voice_orchestrator_controller"

  tags        = var.tags
  environment = var.environment
}
