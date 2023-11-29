resource "azuread_conditional_access_policy" "terraform" {
  display_name = "RequireMFATerraformGroup"
  state        = "enabledForReportingButNotEnforced"

  ### Assignments ###
  conditions {

    # Users
    users {
      included_users = ["GuestsOrExternalUsers"]
      excluded_users = []

      included_groups = var.group_ids
      excluded_groups = []

      included_roles = []
      excluded_roles = []
    }

    # Targer resources
    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    # Conditions
    user_risk_levels    = ["low", "medium", "high"]
    sign_in_risk_levels = ["low", "medium", "high"]

    platforms {
      included_platforms = ["all"]
      excluded_platforms = []
    }

    locations {
      included_locations = ["All"]
      excluded_locations = ["AllTrusted"]
    }

    client_app_types = ["all"]

    devices {
      filter {
        mode = "exclude"
        rule = "device.operatingSystem eq \"Doors\""
      }
    }
  }

  ### Access Controls ###
  # Grant
  grant_controls {
    operator          = "OR"
    built_in_controls = ["mfa"]
  }

  # Session
  session_controls {
    application_enforced_restrictions_enabled = true
    disable_resilience_defaults               = false
    sign_in_frequency                         = 10
    sign_in_frequency_period                  = "hours"
    cloud_app_security_policy                 = "monitorOnly"
  }
}
