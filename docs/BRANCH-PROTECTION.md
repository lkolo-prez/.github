# Branch protection (GitHub Rulesets)

This is the organization `.github` repo: its **reusable workflows are consumed by every other
repo in the org**. A change here propagates to everyone's CI/CD supply chain, so `main` must be
protected at least as strictly as any production service — arguably more.

Configure it under **Settings → Rules → Rulesets → New branch ruleset**, or apply it as code
with the GitHub API / Terraform.

## Target

- **Ruleset name**: `protect-main`
- **Enforcement status**: Active
- **Target branches**: include the default branch (`main`).
- **Bypass list**: empty (no roles or apps bypass — not even admins).

## Required rules

| Rule | Setting |
| --- | --- |
| Restrict deletions | ✅ on |
| Restrict force pushes (non-fast-forward) | ✅ on |
| Require linear history | ✅ on |
| Require signed commits | ✅ on |
| Require a pull request before merging | ✅ on |
| — Required approvals | **2** (consider CODEOWNERS = security + platform leads) |
| — Dismiss stale approvals on new commits | ✅ on |
| — Require review from Code Owners | ✅ on (see [`.github/CODEOWNERS`](../.github/CODEOWNERS)) |
| — Require approval of the most recent push | ✅ on |
| — Require conversation resolution before merging | ✅ on |
| Require status checks to pass | ✅ on |
| — Require branches to be up to date before merging | ✅ on |
| Block force pushes | ✅ on |

## Required status checks

Add these checks (the job `name:` values from the workflows) as **required**:

- `actionlint + zizmor + SHA-pin check` — from [`actionlint.yml`](../.github/workflows/actionlint.yml)
- `Scorecard analysis` — from [`scorecard.yml`](../.github/workflows/scorecard.yml)

> The `reusable-*.yml` files are `workflow_call` definitions consumed by other repos; they do not
> run as checks on this repo. The `actionlint + zizmor + SHA-pin check` job is what guards their
> quality and SHA-pinning on every PR here.

## Releasing reusable workflows safely

Consumers pin to this repo by commit SHA (`uses: aircloud/.github/.github/workflows/<name>.yml@<sha>`).
To let them upgrade deliberately:

- Tag releases (`v1`, `v1.2.0`) and move the major tag (`v1`) only after CI is green.
- Treat any edit to a `reusable-*.yml` as a security change: require the `security` CODEOWNER review.
- Never force-push or rewrite history — a moved SHA silently changes every consumer's pipeline.

## Signed commits

```bash
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgsign true
# Add the key under GitHub → Settings → SSH and GPG keys → "Signing Key".
```

## Apply as code (optional)

```bash
gh api -X POST repos/aircloud/.github/rulesets \
  --input .github/rulesets/protect-main.json
```

or manage it with the `integrations/github` Terraform provider (`github_repository_ruleset`).
