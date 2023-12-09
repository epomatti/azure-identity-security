variable "entraid_tenant_domain" {
  type = string
}

variable "generic_password" {
  type      = string
  sensitive = true
}

variable "conditional_policy_named_location_ips" {
  type = list(string)
}
