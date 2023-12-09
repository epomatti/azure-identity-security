resource "azuread_named_location" "terraform" {
  display_name = "TerraformIPs"

  ip {
    ip_ranges = var.ip_ranges
    trusted   = true
  }
}
