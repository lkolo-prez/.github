<!--
  Thanks for the contribution! The PR title MUST be a valid Conventional Commit
  (e.g. "feat(reusable-ci): add coverage gate"), because we squash-merge and the
  title becomes the changelog entry consumed by release-please.
-->

## What & why

<!-- A clear, concise description of the change and the problem it solves. -->

Closes #

## Type of change

- [ ] `fix` — bug fix (patch)
- [ ] `feat` — new feature (minor)
- [ ] `feat!` / `BREAKING CHANGE` — breaking change (major)
- [ ] `docs` / `ci` / `chore` / `refactor` / `test` — non-release

## Reusable-workflow impact (if applicable)

<!-- Changing files under .github/workflows/reusable-*.yml affects EVERY consuming repo. -->

- [ ] Not applicable.
- [ ] Inputs / secrets / outputs changed — documented in the workflow header **and** README.
- [ ] Default behavior changed — marked as **breaking** (`!` / `BREAKING CHANGE:`).
- [ ] New behavior added behind a new input with a safe default (non-breaking).
- [ ] Updated the SHA in `examples/consumer-ci.yml` (after release) / noted migration in the description.

## Checklist

- [ ] My commits are **signed** (verified) and follow **Conventional Commits**.
- [ ] `make lint test` passes locally (and `make security` if I touched CI).
- [ ] All third-party Actions are **pinned to a 40-hex SHA** with a trailing version comment.
- [ ] Workflows keep **least-privilege** `permissions`, a `concurrency:` group, and `harden-runner` first.
- [ ] No secrets added; cloud auth uses **OIDC**.
- [ ] Docs updated (`README.md` / `docs/`) where relevant.
- [ ] I have read [`CONTRIBUTING.md`](../CONTRIBUTING.md) and the [Code of Conduct](../CODE_OF_CONDUCT.md).

## How was this tested?

<!-- Commands, CI run links, screenshots, or sample consumer run. -->
