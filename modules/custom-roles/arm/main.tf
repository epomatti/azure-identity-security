data "azurerm_subscription" "primary" {
}

resource "azurerm_role_definition" "terraform" {
  name        = "TERRAFORM-custom-role"
  scope       = data.azurerm_subscription.primary.id
  description = "This is a custom role created via Terraform"

  permissions {
    actions          = ["Microsoft.Resources/subscriptions/resourceGroups/read"]
    data_actions     = ["Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read"]
    not_actions      = []
    not_data_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id,
  ]
}
