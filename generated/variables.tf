variable "common_tags" {
  description = "Tags recorded on reconstructed resources."
  type        = list(string)
  default     = ["managed_by:terraform", "source:plan-log-reverse-engineer"]
}
