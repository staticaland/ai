# AI Project Scaffolding

This project includes scaffolding for GitHub Copilot instruction and prompt files to enhance AI-assisted development workflows.

## Structure

```
.github/
├── copilot-instructions.md    # General instructions for all Copilot requests
├── instructions/              # Directory for specialized instruction files
│   └── terraform.instructions.md  # Terraform-specific instructions
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
- **`.github/instructions/terraform.instructions.md`** - Terraform-specific best practices (applies only to `*.tf`, `*.tfvars` files)

These instructions help maintain consistency across:

- Code generation
- Test creation
- Code reviews
- Documentation
- Infrastructure as Code

### Prompt Files

Prompt files in `.github/prompts/` are reusable templates for common development tasks:

#### Available Prompts

1. **`create-component`** - Generate new components with proper structure and TypeScript types
2. **`create-api`** - Create REST API endpoints with validation and proper error handling
3. **`refactor-code`** - Refactor code for better maintainability and performance
4. **`debug-issue`** - Systematic debugging assistance with structured approach
5. **`terraform-infrastructure`** - Create and manage Terraform infrastructure with best practices

#### Usage

In VS Code with Copilot Chat:

1. Type `@workspace` followed by `/` and the prompt name (e.g., `@workspace /create-component`)
2. Or run **Chat: Run Prompt** from Command Palette
3. Or click the play button when viewing a prompt file

### Settings

The `.vscode/settings.json` file enables and configures:

- Experimental prompt files feature (`chat.promptFiles`)
- Instruction files for code generation (`chat.instructionsFilesLocations`)
- Custom locations for prompt files (`chat.promptFilesLocations`)
- Specific instructions for different request types (code generation, testing, reviews, etc.)
- File associations for better `.prompt.md` file handling

## Getting Started

1. **Enable the features**: The workspace settings are already configured
2. **Customize instructions**: Edit `.github/copilot-instructions.md` for your project-specific guidelines
3. **Add specialized instructions**: Create new instruction files in `.github/instructions/` for specific technologies
4. **Create custom prompts**: Add new `.prompt.md` files in `.github/prompts/` following the existing patterns
5. **Use in development**: Access prompts via VS Code Copilot Chat with `@workspace /prompt-name`

## Best Practices

- **Instruction files** should contain general guidelines and coding standards
- **Prompt files** should be specific, actionable templates for common tasks
- Use descriptive names for prompt files that clearly indicate their purpose
- Include examples and expected outputs in prompt files
- Regularly update instructions based on project evolution and team feedback

## References

- [VS Code Copilot Customization Documentation](https://code.visualstudio.com/docs/copilot/copilot-customization)
- [GitHub Copilot Chat Documentation](https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-chat)
- [Copilot Instructions Documentation](https://docs.github.com/en/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot)
