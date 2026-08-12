# Reverse-engineered branch module.

module "no_messages_visible_on_topic" {
  source = "./no_messages_visible_on_topic"

  tags        = var.tags
  environment = var.environment
}
