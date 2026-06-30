# Makefile for aircloud/.github — org defaults & reusable workflows.
# This repo ships configuration (not a service), so `build`/`run` validate templates rather than compile code.

SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help

# Tool versions used by local scans (kept close to the CI-pinned versions).
TRIVY_VERSION   ?= 0.58.1
SYFT_VERSION    ?= 1.18.1
ZIZMOR_VERSION  ?= 1.0.0

WORKFLOW_DIRS := .github/workflows examples

.PHONY: help
help: ## Show this help
	@grep -hE '^[a-zA-Z0-9_-]+:.*?## ' $(MAKEFILE_LIST) \
		| awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup: ## Install local tooling and pre-commit hooks
	@echo ">> Installing pre-commit hooks"
	@command -v pre-commit >/dev/null 2>&1 || pip install --user pre-commit
	@pre-commit install --install-hooks
	@echo ">> Installing actionlint, yamllint, zizmor (best-effort)"
	@command -v actionlint >/dev/null 2>&1 || echo "   actionlint: install via 'brew install actionlint' or go install"
	@command -v yamllint   >/dev/null 2>&1 || pip install --user yamllint
	@command -v zizmor      >/dev/null 2>&1 || pip install --user "zizmor==$(ZIZMOR_VERSION)"
	@echo ">> Done. Run 'make lint' to verify."

.PHONY: lint
lint: ## Lint workflows: actionlint + yamllint + zizmor + SHA-pin check
	@echo ">> actionlint"
	@command -v actionlint >/dev/null 2>&1 && actionlint || echo "   (actionlint not installed; skipping)"
	@echo ">> yamllint"
	@command -v yamllint >/dev/null 2>&1 && yamllint . || echo "   (yamllint not installed; skipping)"
	@echo ">> zizmor (workflow security audit)"
	@command -v zizmor >/dev/null 2>&1 && zizmor $(WORKFLOW_DIRS) || echo "   (zizmor not installed; skipping)"
	@$(MAKE) --no-print-directory check-pins

.PHONY: check-pins
check-pins: ## Verify all GitHub Actions are pinned to a full 40-hex SHA
	@echo ">> Checking that all 'uses:' are pinned to a 40-hex SHA"
	@if grep -rEn '^[[:space:]]*uses:[[:space:]]*' $(WORKFLOW_DIRS) 2>/dev/null \
		| grep -vE 'uses:[[:space:]]*\./' \
		| grep -vE 'uses:[[:space:]]*[^@]+@[0-9a-f]{40}([[:space:]]|$$|#)'; then \
		echo "ERROR: found unpinned action references above."; exit 1; \
	else echo "   OK: all actions SHA-pinned."; fi

.PHONY: format
format: ## Apply formatting (prettier/yamlfmt if available)
	@command -v prettier >/dev/null 2>&1 && prettier --write "**/*.{md,yml,yaml,json}" || \
		echo "   (prettier not installed; skipping markdown/yaml format)"

.PHONY: format-check
format-check: ## Check formatting without writing
	@command -v prettier >/dev/null 2>&1 && prettier --check "**/*.{md,yml,yaml,json}" || \
		echo "   (prettier not installed; skipping format check)"

.PHONY: test
test: ## Validate community-health YAML, issue templates, and example workflows
	@echo ">> Validating YAML syntax"
	@for f in $$(git ls-files '*.yml' '*.yaml' 2>/dev/null || find . -name '*.y*ml' -not -path './.git/*'); do \
		python3 -c "import sys,yaml; yaml.safe_load(open('$$f'))" || { echo "Invalid YAML: $$f"; exit 1; }; \
	done
	@echo ">> Checking required community-health files exist"
	@for f in SECURITY.md CODE_OF_CONDUCT.md CONTRIBUTING.md SUPPORT.md GOVERNANCE.md LICENSE \
		.github/CODEOWNERS .github/dependabot.yml .github/FUNDING.yml \
		.github/PULL_REQUEST_TEMPLATE.md .github/ISSUE_TEMPLATE/bug.yml \
		.github/ISSUE_TEMPLATE/feature.yml .github/ISSUE_TEMPLATE/config.yml profile/README.md; do \
		test -f "$$f" || { echo "MISSING: $$f"; exit 1; }; \
	done
	@echo "   OK: all required files present and YAML valid."

.PHONY: build
build: test ## Validate templates (no compiled artifact in this repo)
	@echo ">> This repo ships configuration; 'build' validates templates (see 'make test')."

.PHONY: run
run: ## Print how to consume the reusable workflows
	@echo "Consume the reusable workflows from another repo, e.g.:"
	@echo "  uses: aircloud/.github/.github/workflows/reusable-ci.yml@<40-hex-sha> # vX.Y.Z"
	@echo "See examples/consumer-ci.yml for a full example."

.PHONY: security
security: ## Local security scans: gitleaks + trivy filesystem
	@echo ">> gitleaks"
	@command -v gitleaks >/dev/null 2>&1 && gitleaks detect --no-banner --redact || \
		echo "   (gitleaks not installed; CI will run it)"
	@echo ">> trivy fs"
	@command -v trivy >/dev/null 2>&1 && trivy fs --scanners vuln,secret,misconfig --severity CRITICAL,HIGH . || \
		echo "   (trivy not installed; CI will run it)"

.PHONY: sbom
sbom: ## Generate a CycloneDX SBOM of the repo with syft
	@command -v syft >/dev/null 2>&1 && syft scan dir:. -o cyclonedx-json=sbom.cdx.json && \
		echo ">> Wrote sbom.cdx.json" || echo "   (syft not installed; CI generates SBOMs)"

.PHONY: clean
clean: ## Remove generated artifacts
	@rm -f sbom*.json sbom*.xml *.sarif trivy-results.* plan.txt
	@echo ">> Cleaned."
