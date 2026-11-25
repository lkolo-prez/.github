<div align="center">

# AIRCLOUD

**Cloud-native DevOps & platform engineering, built secure by default.**

[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/lkolo-prez/.github/badge)](https://securityscorecards.dev/viewer/?uri=github.com/lkolo-prez/.github)
[![SLSA 3](https://slsa.dev/images/gh-badge-level3.svg)](https://slsa.dev)
[![License: Apache-2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

</div>

---

We build and operate cloud infrastructure, CI/CD platforms, and developer tooling — with a strong bias toward
**supply-chain security**, **reproducibility**, and **least privilege**. Everything we ship is signed, has an
SBOM, and carries build provenance.

## How we work

- **Secure by default.** Hardened CI runners, OIDC-only cloud auth (no long-lived secrets), keyless signing,
  SBOM + provenance attestation on every artifact.
- **Open standards.** SLSA, CycloneDX, Sigstore/cosign, OpenSSF Scorecard, Conventional Commits, SemVer.
- **Reusable foundations.** Our shared CI/CD lives in [`lkolo-prez/.github`](https://github.com/lkolo-prez/.github) —
  every repo composes the same battle-tested, SHA-pinned reusable workflows.
- **AI-assisted, human-reviewed.** We standardize AI assistant configuration (`CLAUDE.md`, `AGENTS.md`,
  Copilot, Cursor) so guidance is consistent and reviewable.

## Start here

| I want to… | Go to |
| --- | --- |
| Understand our shared CI/CD | [`lkolo-prez/.github`](https://github.com/lkolo-prez/.github) |
| Report a security issue | [Security policy](https://github.com/lkolo-prez/.github/security/policy) |
| Contribute | [Contributing guide](https://github.com/lkolo-prez/.github/blob/main/CONTRIBUTING.md) |
| Get support | [Support](https://github.com/lkolo-prez/.github/blob/main/SUPPORT.md) |

## Engineering principles

1. **If it isn't signed, it didn't happen.** Artifacts without provenance don't reach production.
2. **Pin everything.** Actions to SHAs, images to digests, dependencies to lockfiles.
3. **Least privilege, always.** Workflow tokens start at `contents: read`.
4. **Automate the boring parts.** Releases, dependency bumps, and security scans run themselves.

---

<div align="center">
<sub>© 2026 AIRCLOUD · Licensed under Apache-2.0 · <a href="https://aircloud.com.pl">aircloud.com.pl</a> · <code>office@aircloud.com.pl</code></sub>
</div>
