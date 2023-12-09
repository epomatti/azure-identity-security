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

## Conditional Access

A conditional access will be create with `Report-only` functionality. Change to `On` when ready.

This policy will require MFA when for risky logins.

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

### Cloud Apps

Cloud Apps such as Docusign and AWS.

### Sign-in frequency

Options such as periodic authentication (hours, days) or every time.

### Persistent Browser Session

> A persistent browser session allows users to remain signed in after closing and reopening their browser window.

Must have `All cloud apps` enabled.

### Continuous Access Evaluation (CAE)

> Continuous Access Evaluation (CAE) allows access tokens to be revoked based on critical events and policy evaluation in real time rather than relying on token expiration based on lifetime.

-- 

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
