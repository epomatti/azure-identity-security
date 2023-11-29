terraform {
  required_providers {
    # azurerm = {
    #   source  = "hashicorp/azurerm"
    #   version = "3.82.0"
    # }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.46.0"
    }
  }
}

module "users" {
  source                = "./modules/users"
  entraid_tenant_domain = var.entraid_tenant_domain
  generic_password      = var.generic_password
}

module "conditional_access" {
  source    = "./modules/conditional-access/mfa"
  group_ids = module.users.group_ids
}
