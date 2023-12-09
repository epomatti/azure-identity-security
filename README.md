# Azure Identity security

Security implementation for various services from the Azure Identity domain.

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

fasdf

### Persistent Browser Session

Must have `All cloud apps` enabled.

### Continuous Access Evaluation (CAE)

[1]: https://learn.microsoft.com/en-us/entra/id-protection/howto-identity-protection-investigate-risk
[2]: https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/combatting-risky-sign-ins-in-azure-active-directory/ba-p/3724786#:~:text=For%20each%20risky%20sign%20in,risk%2C%20risk%20history%20of%20users.
[3]: https://learn.microsoft.com/en-us/entra/id-protection/howto-identity-protection-simulate-risk
[4]: https://learn.microsoft.com/en-us/entra/fundamentals/security-defaults#protect-privileged-activities-like-access-to-the-azure-portal
[5]: https://learn.microsoft.com/en-us/entra/id-protection/howto-identity-protection-simulate-risk#anonymous-ip-address
