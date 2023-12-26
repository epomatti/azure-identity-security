data "azuread_client_config" "current" {}

locals {
  password = "cvds89avF!sd980vzx"
}

### Users ###
resource "azuread_group" "master" {
  display_name     = "MasterGroup"
  security_enabled = true
}

resource "azuread_group" "sample" {
  display_name     = "SampleGroup"
  security_enabled = true
}

resource "azuread_user" "sample" {
  account_enabled     = true
  user_principal_name = "sample@${var.entraid_tenant_domain}"
  display_name        = "sample"
  password            = local.password
}

resource "azuread_application" "enterprise_app_sample" {
  display_name = "enterprise-app-sample"
}

resource "azuread_service_principal" "principal" {
  client_id = azuread_application.enterprise_app_sample.client_id

  feature_tags {
    enterprise            = true
    custom_single_sign_on = true
  }
}

### Adding to the group ###
resource "azuread_group_member" "sample_group" {
  group_object_id  = azuread_group.master.id
  member_object_id = azuread_group.sample.id
}

resource "azuread_group_member" "sample_user" {
  group_object_id  = azuread_group.master.id
  member_object_id = azuread_user.sample.id
}

resource "azuread_group_member" "enterprise_app_sample" {
  group_object_id  = azuread_group.master.id
  member_object_id = azuread_service_principal.principal.object_id
}
