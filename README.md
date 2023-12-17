# Azure Identity security

Security implementation for various services from the Azure Identity domain.

> ⚠️ If you disable security defaults to test conditional access, don't forget to re-enable it

## Setup

Initiate the baseline resources:

> You must disable [security defaults][4] to use conditional access.

```sh
# Set up according to your Tenant
cp config/sample.tfvars .auto.tfvars

# Create the resources
terraform init
terraform apply -auto-approve
```

## Password rest

### Self-service password reset

You can configure this: `None`, `Selected`, `All`

### Authentication methods

Number of methods required to reset (1 or 2), and the methods available.

<img src=".img/entra-password.png" />

### Registration

Require users to register when signing in, number of days before users are asked to re-confirm their authentication information.

### On-premises integration

<img src=".img/entra-password-onpremises-integration.png" />

## Access Reviews

What to review:
- Teams + Groups
  - All Microsoft 365 groups with guest users
  - Select Teams + Groups 
- Applications

It is possible to create multi-stage.

Reviewers:

- Group owners(s)
- Selected user(s) or group(s)
- Users review their own access - if they can't, group owner reviews
- Managers of users

Recurrence is set.

Settings are then configured such as apply or not the results to resource, no response behavior, notifications, justifications, etc.

## Policy exclusions

It is important to remind that inclusions are overwritten by [exclusions][6]:

> When organizations both include and exclude a user or group, the user or group is excluded from the policy. The exclude action overrides the include action in policy. Exclusions are commonly used for emergency access or break-glass accounts.

## Identity Protection

Risk reports:

> Based of the portal, but also on the [documentation][1] and [blob][2]

- Risky users
- Risky workload identities
- Risky sign-ins
- Risk detections

You can enable User and Sign-in risk protection directly, or use Conditional Access (recommended).

Microsoft provides this [article][3] with tips for simulating risk events.

For example, simulating [anonymous IP address][5] using Tor browser to access https://myapps.microsoft.com/ (set the Risk level to `Low` in the dashboard).

<img src=".img/entra-signin-risk.png" />

## Conditional Access

A conditional access will be create with `Report-only` functionality. Change to `On` when ready.

This policy will require MFA when for risky logins.

### Cloud Apps

Cloud Apps such as Docusign and AWS.

### Sign-in frequency

Options such as periodic authentication (hours, days) or every time.

### Persistent Browser Session

> A persistent browser session allows users to remain signed in after closing and reopening their browser window.

Must have `All cloud apps` enabled.

### Continuous Access Evaluation (CAE)

> Continuous Access Evaluation (CAE) allows access tokens to be revoked based on critical events and policy evaluation in real time rather than relying on token expiration based on lifetime.

## MFA Policy

There is also a dedicated available MFA policy:

<img src=".img/entra-mfa.png" />

## MFA Additional Settings

To reach the MFA additional settings hot site:

<img src=".img/entra-mfa-additional-init.png" />

<img src=".img/entra-mfa-additional.png" />

## MFA Statues

Users can have the following [MFA statuses][7]:

- **Disabled (default)** - User not enrolled in per-user Microsoft Entra MFA. Does not affect Legacy, browser, or modern.
- **Enabled** - User is enrolled in per-user Microsoft Entra MFA, but can still use password for legacy authentication. Will be prompted to register for modern authentication when session or token expires.
- **Enforced** - User is enrolled per-user Microsoft Entra MFA and must sign-in with MFA.

Importantly:

> Don't enable or enforce per-user Microsoft Entra multifactor authentication if you use Conditional Access policies.

By accessing "All Users" > "Per-user MFA":

<img src=".img/entra-mfa-peruser.png" />

---

### Clean-up

> ⚠️ If you disable security defaults to test conditional access, don't forget to re-enable it

```sh
terraform destroy -auto-approve
```

[1]: https://learn.microsoft.com/en-us/entra/id-protection/howto-identity-protection-investigate-risk
[2]: https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/combatting-risky-sign-ins-in-azure-active-directory/ba-p/3724786#:~:text=For%20each%20risky%20sign%20in,risk%2C%20risk%20history%20of%20users.
[3]: https://learn.microsoft.com/en-us/entra/id-protection/howto-identity-protection-simulate-risk
[4]: https://learn.microsoft.com/en-us/entra/fundamentals/security-defaults#protect-privileged-activities-like-access-to-the-azure-portal
[5]: https://learn.microsoft.com/en-us/entra/id-protection/howto-identity-protection-simulate-risk#anonymous-ip-address
[6]: https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-conditional-access-users-groups#exclude-users
[7]: https://learn.microsoft.com/en-us/entra/identity/authentication/howto-mfa-userstates#microsoft-entra-multifactor-authentication-user-states
