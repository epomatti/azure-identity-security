data "azuread_client_config" "current" {}

locals {
  owner1   = "Owner1"
  member1  = "Member1"
  password = "cvds89avF!sd980vzx"
}

resource "azuread_user" "owner1" {
  account_enabled     = true
  user_principal_name = "${local.owner1}@${var.entraid_tenant_domain}"
  display_name        = local.owner1
  mail_nickname       = local.owner1
  password            = local.password
}

resource "azuread_group" "group1" {
  display_name     = "Group1"
  owners           = [azuread_user.owner1.object_id]
  security_enabled = true
}

resource "azuread_user" "member1" {
  account_enabled     = true
  user_principal_name = "${local.member1}@${var.entraid_tenant_domain}"
  display_name        = local.member1
  mail_nickname       = local.member1
  password            = local.password
}

resource "azuread_group_member" "member1" {
  group_object_id  = azuread_group.group1.id
  member_object_id = azuread_user.member1.id
}
