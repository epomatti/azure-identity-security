resource "azuread_group" "nesting_group1" {
  display_name       = "NestingGroup1"
  security_enabled   = true
  assignable_to_role = true

  # Microsoft 365 group
  mail_enabled  = true
  mail_nickname = "NestingGroup1"
  types         = ["Unified"]
}

resource "azuread_group" "nesting_group2" {
  display_name       = "NestingGroup2"
  security_enabled   = true
  assignable_to_role = false
}

resource "azuread_group" "nesting_group3" {
  display_name       = "NestingGroup3"
  security_enabled   = true
  assignable_to_role = true
}

resource "azuread_group" "nesting_group4" {
  display_name       = "NestingGroup4"
  security_enabled   = true
  assignable_to_role = true
}
