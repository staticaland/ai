.PHONY: format-md format-md-check help install-prettier

# Default target
help:
	@echo "Available targets:"
	@echo "  format-md        - Format all markdown files with Prettier"
	@echo "  format-md-check  - Check markdown formatting without making changes"
	@echo "  install-prettier - Install Prettier locally via npm"
	@echo "  help            - Show this help message"

# Install Prettier locally if not already installed
install-prettier:
	@if ! command -v npx >/dev/null 2>&1; then \
		echo "Error: npm/npx not found. Please install Node.js first."; \
		exit 1; \
	fi
	@if ! npx prettier --version >/dev/null 2>&1; then \
		echo "Installing Prettier..."; \
		npm install --save-dev prettier; \
	else \
		echo "Prettier is already available."; \
	fi

# Format all markdown files
format-md:
	@echo "Formatting markdown files..."
	@npx prettier --write \
		--parser markdown \
		--prose-wrap preserve \
		--tab-width 2 \
		"**/*.md"

# Check markdown formatting without making changes
format-md-check:
	@echo "Checking markdown file formatting..."
	@npx prettier --check \
		--parser markdown \
		--prose-wrap preserve \
		--tab-width 2 \
		"**/*.md" 