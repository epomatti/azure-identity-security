terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.47.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.94.0"
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

module "named_location" {
  source    = "./modules/conditional-access/named-location"
  ip_ranges = var.conditional_policy_named_location_ips
}

module "access_review" {
  count                 = var.create_access_review ? 1 : 0
  source                = "./modules/access-review"
  entraid_tenant_domain = var.entraid_tenant_domain
}

module "custom_role_entra" {
  source = "./modules/custom-roles/entra"
}

module "custom_role_azure_resource_manager" {
  source = "./modules/custom-roles/arm"
}

resource "azurerm_resource_group" "lifecycleworkflow" {
  name     = "rg-lifecycleworkflow"
  location = var.location
}

module "lifecycle_workflow" {
  count                 = var.create_lcw ? 1 : 0
  source                = "./modules/lifecycle-workflow"
  entraid_tenant_domain = var.entraid_tenant_domain
  location              = var.location
  resource_group_name   = azurerm_resource_group.lifecycleworkflow.name
}

# module "access_packages" {
#   source = "./modules/access-packages"
# }

### Scenarios ###
module "scenario_adding_stuff_to_groups" {
  source                = "./modules/scenarios/adding-stuff-to-groups"
  entraid_tenant_domain = var.entraid_tenant_domain
}

module "scenario_group_nesting" {
  source = "./modules/scenarios/group-nesting"
}
