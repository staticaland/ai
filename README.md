# AI Project Scaffolding

This project includes scaffolding for GitHub Copilot instruction and prompt files to enhance AI-assisted development workflows.

## Structure

```
.github/
├── copilot-instructions.md    # General instructions for all Copilot requests
├── terraform.instructions.md  # Terraform-specific instructions
└── prompts/                   # Reusable prompt files
    ├── create-component.prompt.md
    ├── create-api.prompt.md
    ├── refactor-code.prompt.md
    ├── debug-issue.prompt.md
    └── terraform-infrastructure.prompt.md

.vscode/
└── settings.json             # VS Code configuration for enabling features
```

## How to Use

### Instruction Files

The instruction files contain guidelines that are automatically included in Copilot requests:

- **`.github/copilot-instructions.md`** - General guidelines for all development tasks
- **`.github/terraform.instructions.md`** - Terraform-specific best practices (applies only to `*.tf`, `*.tfvars` files)

These instructions help maintain consistency across:
- Code generation
- Test creation  
- Code reviews
- Documentation
- Infrastructure as Code

### Prompt Files

Prompt files in `.github/prompts/` are reusable templates for common development tasks:

#### Available Prompts

1. **`/create-component`** - Generate new components with proper structure
2. **`/create-api`** - Create REST API endpoints with validation
3. **`/refactor-code`** - Refactor code for better maintainability
4. **`/debug-issue`** - Systematic debugging assistance
5. **`/terraform-infrastructure`** - Create and manage Terraform infrastructure

#### Usage

In VS Code with Copilot Chat:

1. Type `/` followed by the prompt name (e.g., `/create-component`)
2. Or run **Chat: Run Prompt** from Command Palette
3. Or click the play button when viewing a prompt file

### Settings

The `.vscode/settings.json` file enables and configures:

- Experimental prompt files feature
- Instruction files for code generation
- Custom locations for prompt and instruction files
- Specific instructions for different request types

## Getting Started

1. **Enable the features**: The workspace settings are already configured
2. **Customize instructions**: Edit `.github/copilot-instructions.md` for your project
3. **Create custom prompts**: Add new `.prompt.md` files in `.github/prompts/`
4. **Use in development**: Access prompts via VS Code Copilot Chat

## References

- [VS Code Copilot Customization Documentation](https://code.visualstudio.com/docs/copilot/copilot-customization)
- [GitHub Copilot Chat Documentation](https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-chat)
