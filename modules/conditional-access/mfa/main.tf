resource "azuread_conditional_access_policy" "terraform" {
  display_name = "RequireMFATerraformGroup"
  state        = "enabledForReportingButNotEnforced"

  ### Assignments ###
  conditions {

    # Users
    users {
      included_users = []
      excluded_users = []

      included_guests_or_external_users {
        guest_or_external_user_types = [
          "internalGuest",
          "b2bCollaborationGuest",
          "b2bCollaborationMember",
          "b2bDirectConnectUser",
          "otherExternalUser",
          "serviceProvider",
        ]
        external_tenants {
          members         = []
          membership_kind = "all"
        }
      }

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
    user_risk_levels    = ["high", "medium", "low"]
    sign_in_risk_levels = ["high", "medium", "low"]

    platforms {
      included_platforms = ["all"]

      # Not sure why Entra keeps adding these
      excluded_platforms = [
        "android",
        "iOS",
        "macOS",
        "linux",
      ]
    }

    locations {
      included_locations = ["All"]
      excluded_locations = ["AllTrusted"]
    }

    # Control user access to target specific client applications not using modern authentication.
    client_app_types = ["exchangeActiveSync", "browser", "mobileAppsAndDesktopClients", "other"]

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
