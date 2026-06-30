<div align="center">

# aircloud

**Cloud-native DevOps & platform engineering, built secure by default.**

[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/aircloud/.github/badge)](https://securityscorecards.dev/viewer/?uri=github.com/aircloud/.github)
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
- **Reusable foundations.** Our shared CI/CD lives in [`aircloud/.github`](https://github.com/aircloud/.github) —
  every repo composes the same battle-tested, SHA-pinned reusable workflows.
- **AI-assisted, human-reviewed.** We standardize AI assistant configuration (`CLAUDE.md`, `AGENTS.md`,
  Copilot, Cursor) so guidance is consistent and reviewable.

## Start here

| I want to… | Go to |
| --- | --- |
| Understand our shared CI/CD | [`aircloud/.github`](https://github.com/aircloud/.github) |
| Report a security issue | [Security policy](https://github.com/aircloud/.github/security/policy) |
| Contribute | [Contributing guide](https://github.com/aircloud/.github/blob/main/CONTRIBUTING.md) |
| Get support | [Support](https://github.com/aircloud/.github/blob/main/SUPPORT.md) |

## Engineering principles

1. **If it isn't signed, it didn't happen.** Artifacts without provenance don't reach production.
2. **Pin everything.** Actions to SHAs, images to digests, dependencies to lockfiles.
3. **Least privilege, always.** Workflow tokens start at `contents: read`.
4. **Automate the boring parts.** Releases, dependency bumps, and security scans run themselves.

---

<div align="center">
<sub>© 2026 aircloud · Licensed under Apache-2.0 · <code>security@aircloud.example</code></sub>
</div>
