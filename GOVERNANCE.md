# Governance

This document describes how the `aircloud` organization makes decisions, who is responsible for what, and how
people gain (and lose) maintainer privileges. It applies org-wide, with `aircloud/.github` as the canonical
source.

## Roles

| Role | Who | Responsibilities |
| --- | --- | --- |
| **Contributor** | Anyone who opens a PR or issue | Follow [`CONTRIBUTING.md`](CONTRIBUTING.md) and the Code of Conduct. |
| **Reviewer** | Trusted contributors with review rights on specific paths | Review PRs, enforce quality gates. Listed in `CODEOWNERS`. |
| **Maintainer** | Owns one or more repos | Merge rights, triage, releases, ruleset enforcement. |
| **Org Owner / Steering** | Small core group | Org settings, security, finances, final escalation. |

Maintainers and owners are listed in each repo's [`.github/CODEOWNERS`](.github/CODEOWNERS) and in the
`@aircloud/*` GitHub teams.

## Decision-making

We favor **lazy consensus**: a proposal with no sustained objections after a reasonable review window is
accepted.

- **Trivial changes** (docs, typo, dependency bump): one maintainer approval.
- **Normal changes**: meet the ruleset requirements (2 approvals incl. CODEOWNERS, green CI).
- **Significant / cross-cutting changes** (new reusable workflow, breaking change, security model change):
  require an **RFC** (see below) and **two maintainer approvals from different teams**.
- **Disputes** that cannot be resolved are escalated to the Steering group, which decides by simple majority.

## RFC process

For substantial changes — especially to the **reusable workflows** that affect every repo — open an RFC:

1. Open an issue using the **Feature request** template, prefixed `RFC:`.
2. Describe motivation, proposed design, alternatives, security impact, and migration/versioning plan.
3. Allow **at least 5 business days** for comment.
4. On consensus, a maintainer opens the implementation PR linking back to the RFC.
5. Breaking changes follow SemVer and the rollout rules in [`CONTRIBUTING.md`](CONTRIBUTING.md#evolving-the-reusable-workflows-important).

## Becoming a maintainer

We invite contributors who have demonstrated, over time:

- Sustained, high-quality contributions.
- Sound code review and adherence to the security posture.
- Good community conduct.

Nominations are made by an existing maintainer and confirmed by lazy consensus among current maintainers. New
maintainers are added to the relevant `@aircloud/*` team and `CODEOWNERS`.

## Stepping down / inactivity

Maintainers may step down at any time. Maintainers inactive for **6 months** may be moved to emeritus status to
keep `CODEOWNERS` accurate; they are welcome back on request.

## Security & releases

- Security policy and SLA: [`SECURITY.md`](SECURITY.md).
- Releases are automated via **release-please** with **SemVer**; see [`CONTRIBUTING.md`](CONTRIBUTING.md).
- Branch protection / rulesets: [`docs/BRANCH-PROTECTION.md`](docs/BRANCH-PROTECTION.md).

## Changing this document

Changes to governance require an RFC and **two Steering approvals**.
