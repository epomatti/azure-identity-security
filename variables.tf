variable "entraid_tenant_domain" {
  type = string
}

variable "generic_password" {
  type      = string
  sensitive = true
}

variable "create_conditional_policy" {
  description = "Rather or not to create the policy, since it requires security defaults to be disabled."
  type        = bool
  default     = false
}

variable "conditional_policy_named_location_ips" {
  type = list(string)
}
