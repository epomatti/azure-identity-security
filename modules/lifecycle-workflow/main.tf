### Groups ###
resource "azuread_group" "lifecycle" {
  display_name     = "LifecycleTestGroup"
  security_enabled = true
}

### Users ###
locals {
  password = "cvds89avF!sd980vzx"
}

resource "azuread_user" "newuser" {
  account_enabled     = true
  user_principal_name = "newuser@${var.entraid_tenant_domain}"
  display_name        = "newuser"
  password            = local.password
  department          = "Marketing"
}

### Logic Apps ###
resource "azurerm_logic_app_workflow" "default" {
  name                = "logic-lifecycle-task"
  location            = var.location
  resource_group_name = var.resource_group_name

  identity {
    type = "SystemAssigned"
  }
}
