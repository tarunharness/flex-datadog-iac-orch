# Reverse-engineered branch module.

module "threadpool_queue_size" {
  source = "./threadpool_queue_size"

  tags        = var.tags
  environment = var.environment
}
