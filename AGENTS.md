# AGENTS.md

Guidance for AI coding agents (Codex, and any tool that implements the [agents.md](https://agents.md) open
standard) working in **`aircloud/.github`**. This complements [`CLAUDE.md`](CLAUDE.md) and
[`.github/copilot-instructions.md`](.github/copilot-instructions.md) — keep all three consistent.

## Project overview

This is the `aircloud` organization's special **`.github`** repository. It provides:

- **Org-default community health files** inherited by every repo lacking its own (`SECURITY.md`,
  `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md`, `SUPPORT.md`, issue/PR templates, `FUNDING.yml`).
- The **public org profile** at `profile/README.md`.
- **Reusable workflows** (`.github/workflows/reusable-*.yml`, `on: workflow_call`) that other repos call by SHA.

`aircloud`, `ghcr.io/aircloud`, and the Azure naming prefix `aircloud` are **placeholders**.

## Setup commands

```bash
make setup     # install pre-commit hooks + actionlint/zizmor/yamllint
```

## Lint / test / validate

```bash
make lint      # actionlint + yamllint + zizmor + "all actions pinned to SHA" check
make format    # apply formatting (prettier/yamlfmt where available)
make test      # validate community-health YAML, issue templates, and example workflows
make security  # gitleaks + trivy fs (local)
make sbom      # generate a CycloneDX SBOM of the repo
```

Always run `make lint test` before proposing changes. CI runs the same checks (`actionlint.yml`).

## Code style & conventions

- YAML: 2-space indent, no tabs, wrap prose at ~120 columns. `Makefile` uses tabs.
- **Conventional Commits** for every commit and PR title (drives release-please / SemVer).
- Commits must be **signed (verified)**.

## Hard constraints (CI enforces these)

1. **Pin all GitHub Actions to a full 40-hex SHA** with a `# vX.Y.Z` comment. No floating tags.
2. Top-level **`permissions: { contents: read }`**; elevate per-job only as needed.
3. **`step-security/harden-runner` first step of every job.**
4. Every workflow declares a **`concurrency:`** group.
5. **No long-lived secrets**: Azure **OIDC** for cloud auth; **cosign keyless** for signing.

## Reusable-workflow versioning (read before editing `.github/workflows/reusable-*.yml`)

- These are **SemVer**-versioned and consumed by every other repo. Consumers **pin by commit SHA**.
- Changing inputs/secrets/outputs or default behavior is **breaking** → `!` / `BREAKING CHANGE:` (major bump).
- Prefer adding new behavior behind **new inputs with safe defaults** (non-breaking).
- Document every input/secret/output in the workflow header and in `README.md`.
- After release, update the SHA in `examples/consumer-ci.yml`.

## PR instructions

- Keep PRs focused. Fill in `.github/PULL_REQUEST_TEMPLATE.md`.
- Ensure `make lint test` passes and the PR title is a valid Conventional Commit.
- Do not weaken `permissions`, remove `harden-runner`, or unpin actions to make CI pass.

## Security

Never commit secrets (gitleaks blocks this). Report vulnerabilities privately per [`SECURITY.md`](SECURITY.md).
