# `aircloud/.github` — Organization defaults & reusable workflows

> [!IMPORTANT]
> **This repository MUST be published under the literal name `.github` inside the `aircloud` GitHub organization.**
> GitHub treats a repository named `.github` as the **special org-level defaults repository**: the community
> health files it contains (e.g. `SECURITY.md`, `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md`, issue/PR templates,
> `FUNDING.yml`) are **automatically inherited by every other repository in the org that does not provide its own**.
> The `profile/README.md` file is rendered as the **public organization landing page**.

This is a **template repository**. The example organization is `aircloud`, the container registry is
`ghcr.io/aircloud`, and the Azure resource-naming prefix is `aircloud`. **All three are placeholders** —
search-and-replace them when you copy this repo into your own org. See [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)
for the full list of replaceable identifiers.

Target year: **2026**.

---

## What lives here

| Path | Purpose | Inherited org-wide? |
| --- | --- | --- |
| `profile/README.md` | Public organization profile (landing page) | n/a (rendered as org page) |
| `SECURITY.md` | Coordinated disclosure policy, `security.txt`, SLA | ✅ default for all repos |
| `CODE_OF_CONDUCT.md` | Contributor Covenant 2.1 | ✅ default for all repos |
| `CONTRIBUTING.md` | Contribution workflow, Conventional Commits, signed commits | ✅ default for all repos |
| `SUPPORT.md` | Where to get help | ✅ default for all repos |
| `GOVERNANCE.md` | Decision-making, maintainership, RFC process | n/a |
| `.github/CODEOWNERS` | Org default code owners | ✅ default for all repos |
| `.github/dependabot.yml` | Grouped Dependabot config (Actions + ecosystems) | ❌ per-repo (template) |
| `.github/ISSUE_TEMPLATE/*` | Bug / feature / config | ✅ default for all repos |
| `.github/PULL_REQUEST_TEMPLATE.md` | PR checklist | ✅ default for all repos |
| `.github/FUNDING.yml` | Sponsor links | ✅ default for all repos |
| `.github/copilot-instructions.md` | Org-wide GitHub Copilot guidance | ❌ per-repo (template) |
| `.github/workflows/reusable-*.yml` | **Reusable** workflows (`on: workflow_call`) | called by consumers |
| `.github/workflows/{scorecard,actionlint}.yml` | This repo's own CI | n/a |
| `examples/consumer-ci.yml` | How a downstream repo wires up the reusable workflows | copy/paste starter |

> [!NOTE]
> Community health files are inherited **only when the consuming repository lacks its own copy**. They are
> *not* inherited into private repos from a public `.github` repo (and vice versa). Reusable **workflows** are
> a different mechanism — they are referenced explicitly via `uses:` and are **not** auto-inherited.

---

## Reusable workflows

All reusable workflows declare `on: workflow_call`, top-level least-privilege `permissions: { contents: read }`,
a `concurrency:` group, and run [`step-security/harden-runner`](https://github.com/step-security/harden-runner)
as the **first step of every job**. Every third-party action is **pinned to a full 40-hex commit SHA** with a
trailing version comment.

| Workflow | Summary |
| --- | --- |
| `reusable-ci.yml` | Language-parameterised lint / format-check / typecheck / test / coverage-gate / build matrix. |
| `reusable-codeql.yml` | CodeQL static analysis (multi-language). |
| `reusable-security.yml` | gitleaks, Trivy filesystem scan, Semgrep, dependency-review, OpenSSF Scorecard. |
| `reusable-container.yml` | Buildx build → SBOM (Syft → CycloneDX) → cosign **keyless** sign → SLSA build-provenance → push to GHCR **by digest** → Trivy image scan → SBOM attestation. |
| `reusable-release.yml` | `release-please` automated, SemVer, Conventional-Commits-driven releases. |
| `reusable-terraform.yml` | fmt / validate / tflint / tfsec / checkov / conftest + `plan` via **Azure OIDC** with a PR comment. |

### Consuming a reusable workflow

Pin the call **by commit SHA**, exactly like any other action:

```yaml
jobs:
  ci:
    uses: aircloud/.github/.github/workflows/reusable-ci.yml@<40-hex-sha> # vX.Y.Z
    with:
      language: node
      node-version: "20"
    permissions:
      contents: read
```

A complete, copy-pasteable example lives in [`examples/consumer-ci.yml`](examples/consumer-ci.yml).

---

## Versioning & how consumers stay safe

Reusable workflows are versioned with **SemVer** and released via `release-please`. **Consumers MUST pin by the
full release commit SHA** (not by `@main`, not by a moving tag) so that an org-side change cannot silently alter
their pipeline. To adopt a new version, bump the SHA in a PR — Renovate/Dependabot will open these PRs for you.
See [`CONTRIBUTING.md`](CONTRIBUTING.md) and [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md#evolving-reusable-workflows).

---

## Supply-chain & security posture

- **OIDC everywhere** — `azure/login` with federated credentials; cosign **keyless** signing. No long-lived cloud secrets.
- **SBOMs** generated with Syft in **CycloneDX** format; **attested** to each image.
- **Provenance** via GitHub build-provenance attestations (SLSA).
- **Scanning**: Trivy (fs + image), Semgrep, CodeQL, gitleaks, OpenSSF Scorecard, dependency-review.
- **Hardened runners**: `step-security/harden-runner` with `egress-policy: block` where feasible.
- **Signed commits** and a documented **GitHub Ruleset** (2 reviews, CODEOWNERS, linear history, required checks):
  see [`docs/BRANCH-PROTECTION.md`](docs/BRANCH-PROTECTION.md).

Report vulnerabilities privately — see [`SECURITY.md`](SECURITY.md).

---

## Local quickstart

```bash
make setup     # install pre-commit, actionlint, etc.
make lint      # actionlint + yamllint + zizmor on workflows
make security  # gitleaks + trivy fs (local)
make test      # validate templates / run checks
```

See the [`Makefile`](Makefile) for all targets.

## License

[Apache-2.0](LICENSE).
