# GitHub Copilot — org-wide custom instructions (`aircloud`)

> This file lives in `aircloud/.github`. It documents the **org-wide** Copilot guidance. GitHub Copilot reads
> `.github/copilot-instructions.md` **per repository**, so copy this file into each repo (or keep it in sync)
> — it is **not** auto-inherited like community health files.

You are assisting on `aircloud` repositories. Follow these rules. When repo-specific instructions conflict,
the **repo's own** instructions win.

## Non-negotiables (security & supply chain)

- **Never** introduce long-lived cloud credentials or secrets in code, workflows, or examples. Use **GitHub
  OIDC** (`azure/login` with federated credentials) and **keyless cosign** signing.
- **Pin every GitHub Action to a full 40-hex commit SHA** with a trailing `# vX.Y.Z` comment. Never suggest
  `@v4`, `@main`, or other floating refs.
- Every workflow must declare top-level least-privilege `permissions:` (start at `contents: read`), elevate
  per-job only as needed, set a `concurrency:` group, and run `step-security/harden-runner` as the **first
  step** of each job (`egress-policy: block` where feasible).
- Prefer calling the org **reusable workflows** in `aircloud/.github` over hand-rolling pipelines.
- Generate/keep an **SBOM** (Syft → CycloneDX) and **cosign signatures** + **SLSA provenance** for artifacts.

## Code style & conventions

- **Conventional Commits** for all commit messages and PR titles (release-please depends on them).
- Match the existing language/formatter/linter in the repo (e.g. Prettier/ESLint, Black/Ruff, gofmt, `terraform
  fmt`). Do not reformat unrelated code.
- Write tests for new behavior; keep or improve coverage (CI enforces a coverage gate).
- Prefer clear, typed, well-named code over cleverness. Add doc comments for public APIs.

## Containers

- Multi-stage builds; **distroless or chiseled** runtime base; non-root `USER`; read-only-rootfs friendly;
  include a `HEALTHCHECK`; keep `hadolint` clean; ship a `.dockerignore`.

## What NOT to do

- Don't add dependencies without a clear need; prefer the standard library.
- Don't disable security scanners or lower severity thresholds to make CI pass.
- Don't hardcode org/registry/prefix names where a variable/input is expected — these (`aircloud`,
  `ghcr.io/aircloud`, the Azure prefix `aircloud`) are placeholders.
- Don't weaken `permissions`, remove `harden-runner`, or unpin actions.

## Helpful context

- Org defaults & reusable workflows: `aircloud/.github`.
- Contribution rules: `CONTRIBUTING.md`. Security policy: `SECURITY.md`. Branch protection:
  `docs/BRANCH-PROTECTION.md`.
