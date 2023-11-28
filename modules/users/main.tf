locals {
  user1 = "User1"
}

resource "azuread_user" "user1" {
  account_enabled     = true
  user_principal_name = "${local.user1}@${var.entraid_tenant_domain}"
  display_name        = local.user1
  mail_nickname       = local.user1
  password            = var.generic_password
}
