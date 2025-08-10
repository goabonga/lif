# SPDX-License-Identifier: MIT
# Copyright (c) 2025 Chris <goabonga@pm.me>


.PHONY: help env install format lint typecheck test license check-license release docs serve-docs build publish clean

VENV = .venv
POETRY_SYNC = $(VENV)/.poetry.sync

help: ## Show this help
	@echo "📘 Available commands:"; \
	grep -E '^[a-zA-Z_-]+:.*?##' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "} {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

env: $(POETRY_SYNC)

$(POETRY_SYNC): pyproject.toml
	@echo "🔧 Installing/updating dependencies with Poetry..."
	@poetry install
	@mkdir -p $(VENV)
	@touch $(POETRY_SYNC)

install: env ## Install dependencies with Poetry
	@echo "📦 Dependencies installed and ready."

clean: ## Clean cache and build files
	@echo "🧹 Cleaning build, cache and virtualenv files..."
	@rm -rf .mypy_cache .pytest_cache .ruff_cache .coverage coverage.xml junit.xml htmlcov site dist $(VENV)
	@find . -type d -name "__pycache__" -exec rm -rf {} +
