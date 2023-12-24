data "azuread_client_config" "current" {}

locals {
  password = "cvds89avF!sd980vzx"
}

### Users ###
resource "azuread_user" "owner1" {
  account_enabled     = true
  user_principal_name = "Owner1@${var.entraid_tenant_domain}"
  display_name        = "Owner1"
  password            = local.password
}

resource "azuread_group" "group1" {
  display_name     = "Group1"
  owners           = [azuread_user.owner1.object_id]
  security_enabled = true
}

resource "azuread_user" "member1" {
  account_enabled     = true
  user_principal_name = "Member1@${var.entraid_tenant_domain}"
  display_name        = "Member1"
  password            = local.password
}

resource "azuread_group_member" "member1" {
  group_object_id  = azuread_group.group1.id
  member_object_id = azuread_user.member1.id
}

### Reviewers ###
resource "azuread_group" "reviewers1" {
  display_name     = "Reviewers1"
  owners           = [azuread_user.owner1.object_id]
  security_enabled = true
}

resource "azuread_user" "reviewer1" {
  account_enabled     = true
  user_principal_name = "Reviewer1@${var.entraid_tenant_domain}"
  display_name        = "Reviewer1"
  password            = local.password
}

resource "azuread_group_member" "reviewers1" {
  group_object_id  = azuread_group.reviewers1.id
  member_object_id = azuread_user.reviewer1.id
}
