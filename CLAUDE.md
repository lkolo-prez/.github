# CLAUDE.md — guidance for Claude Code in this repo

This file gives [Claude Code](https://claude.com/claude-code) the context it needs to work effectively in
**`aircloud/.github`** — the organization's special **defaults & reusable-workflows** repository.

> See also [`AGENTS.md`](AGENTS.md) (the open agents.md standard, used by Codex and others) and
> [`.github/copilot-instructions.md`](.github/copilot-instructions.md). Keep all three consistent.

## What this repo is

- Published under the literal name **`.github`** in the `aircloud` org. Its community-health files
  (`SECURITY.md`, `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md`, issue/PR templates, `FUNDING.yml`) are **inherited
  by every org repo that lacks its own**. `profile/README.md` is the **public org landing page**.
- `.github/workflows/reusable-*.yml` are **reusable workflows** (`on: workflow_call`) that other repos call
  with `uses: aircloud/.github/.github/workflows/<name>.yml@<sha>`.
- `aircloud`, `ghcr.io/aircloud`, and the Azure prefix `aircloud` are **placeholders** — do not hardcode them
  where an input/variable belongs.

## Real commands (use these; do not invent)

All day-to-day tasks go through the `Makefile`:

| Task | Command |
| --- | --- |
| Install local tooling + pre-commit hooks | `make setup` |
| Lint workflows (actionlint + yamllint + zizmor + SHA-pin check) | `make lint` |
| Format / format-check | `make format` |
| Validate templates & run checks | `make test` |
| Local security scans (gitleaks + trivy fs) | `make security` |
| Generate an SBOM locally | `make sbom` |
| Clean generated artifacts | `make clean` |

There is no application to `build`/`run` here; `make build` and `make run` validate the templates and print
usage (this repo ships configuration, not a service).

## Golden rules (do not violate)

1. **Pin every GitHub Action to a full 40-hex commit SHA** with a trailing `# vX.Y.Z` comment. Never `@v4`/`@main`.
   `make lint` fails otherwise.
2. **Least privilege**: top-level `permissions: { contents: read }`; elevate per-job only as needed.
3. **`step-security/harden-runner` is the FIRST step of every job.**
4. Every workflow sets a **`concurrency:` group**.
5. **No long-lived secrets.** Cloud auth = **Azure OIDC**; image signing = **cosign keyless**.
6. Reusable workflows are **SemVer**. Changing inputs/secrets/outputs or default behavior is **breaking**
   (`!` / `BREAKING CHANGE:`). Add new behavior behind new inputs with safe defaults.
7. **Conventional Commits**, **signed** commits. PRs are squash-merged; the title becomes the changelog entry.

## Evolving reusable workflows safely

- Consumers **pin by SHA**, so old pins keep working — never rewrite published history.
- Document every input/secret/output in the workflow header **and** [`README.md`](README.md).
- After a release, update the SHA in [`examples/consumer-ci.yml`](examples/consumer-ci.yml) and note migrations
  in the release notes. See [`CONTRIBUTING.md`](CONTRIBUTING.md#evolving-the-reusable-workflows-important).

## Where things live

```
profile/README.md                    org landing page
SECURITY.md CODE_OF_CONDUCT.md ...    org-default community health files
.github/workflows/reusable-*.yml      reusable workflows (workflow_call)
.github/workflows/{scorecard,actionlint}.yml   this repo's own CI
.github/{CODEOWNERS,dependabot.yml,FUNDING.yml,PULL_REQUEST_TEMPLATE.md,ISSUE_TEMPLATE/}
examples/consumer-ci.yml             how a repo consumes the reusable workflows
docs/{ARCHITECTURE,BRANCH-PROTECTION}.md
```

## When in doubt

- Prefer editing existing files over creating new ones.
- Match the surrounding style; keep YAML 2-space indented; wrap prose at ~120 cols.
- If a change affects consumers, call it out explicitly and follow the versioning rules above.
