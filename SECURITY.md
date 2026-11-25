# Security Policy

> This is the **organization-default** security policy for AIRCLOUD repositories. Repositories that do not ship
> their own `SECURITY.md` inherit this one. Individual repos MAY override it with stricter, project-specific terms.

We take the security of our software and infrastructure seriously. Thank you for helping keep AIRCLOUD and our
users safe through **coordinated disclosure**.

## Supported versions

Unless a repository states otherwise, security fixes are provided for:

| Version | Supported |
| --- | --- |
| Latest minor release | ✅ |
| Previous minor release | ✅ (critical fixes only) |
| Anything older | ❌ |

## Reporting a vulnerability

**Please do NOT open a public issue, PR, or discussion for security reports.**

Use one of these **private** channels:

1. **GitHub Private Vulnerability Reporting (preferred).**
   Go to the affected repository → **Security** tab → **Report a vulnerability**.
   This routes to the maintainers privately and lets us collaborate and request a CVE.
2. **Email:** `office@aircloud.com.pl`.

Please include:
- A description of the issue and its impact.
- Reproduction steps or a proof of concept.
- Affected versions / commit SHA / image digest.
- Any suggested remediation.

### What is in scope

- Source code, container images, and Infrastructure-as-Code published under the `lkolo-prez` account and the `AIRCLOUD-PL` organisation.
- CI/CD reusable workflows in `lkolo-prez/.github`.

### Out of scope

- Findings that require physical access, social engineering of staff, or DoS via volumetric traffic.
- Vulnerabilities in third-party dependencies that already have an upstream advisory and no AIRCLOUD-specific
  exploit path (report those upstream; tell us so we can bump).

## Response SLA

We aim to meet the following timelines (business days, CET):

| Stage | Target |
| --- | --- |
| **Acknowledge** receipt | within **2 business days** |
| **Triage** & severity assessment (CVSS v3.1/v4.0) | within **5 business days** |
| **Status update** cadence | at least every **7 calendar days** until resolved |
| **Fix or mitigation** — Critical (CVSS ≥ 9.0) | target **7 calendar days** |
| **Fix or mitigation** — High (7.0–8.9) | target **30 calendar days** |
| **Fix or mitigation** — Medium/Low | target **90 calendar days** |
| **Public disclosure** | coordinated, typically within **90 days** of report or on patch release, whichever is sooner |

We support and request **coordinated disclosure**: we will credit reporters (opt-in) in release notes and the
advisory. We do not currently run a paid bug-bounty program.

## Our security guarantees

Artifacts we publish are:
- **Signed** with [Sigstore cosign](https://docs.sigstore.dev/) (keyless / OIDC).
- Accompanied by a **CycloneDX SBOM** (generated with Syft) and **attested** to the image.
- Built with **SLSA build provenance** attestations.
- Scanned with Trivy, CodeQL, Semgrep, and gitleaks in CI.

Verify an image signature:

```bash
cosign verify ghcr.io/lkolo-prez/<image>@<digest> \
  --certificate-identity-regexp '^https://github.com/lkolo-prez/' \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com
```

## security.txt

A machine-readable policy is published per [RFC 9116](https://www.rfc-editor.org/rfc/rfc9116) at
<https://aircloud.com.pl/.well-known/security.txt>:

```
Contact: mailto:office@aircloud.com.pl
Expires: 2027-11-23T00:00:00.000Z
Preferred-Languages: pl, en
Canonical: https://aircloud.com.pl/.well-known/security.txt
Policy: https://aircloud.com.pl/privacy
```

## PGP key

No PGP key is published. Send sensitive details through GitHub Private Vulnerability Reporting or ask for a
secure channel at `office@aircloud.com.pl` before sending them.
