# Not working. Maybe due to this: https://github.com/hashicorp/terraform-provider-azuread/issues/1069
resource "azuread_access_package_catalog" "sample" {
  display_name = "sample-catalog"
  description  = "Example catalog created with Terraform"

  # published          = true
  # externally_visible = true
}
