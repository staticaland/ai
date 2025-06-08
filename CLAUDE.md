# Claude Instructions and Rules Best Practices

## Rule File Guidelines

Good rules are focused, actionable, and scoped.

- Keep rules concise. Under 500 lines is a good target
- Split large concepts into multiple, composable rules
- Provide concrete examples or referenced files when helpful
- Avoid vague guidance. Write rules the way you would write a clear internal doc
- Reuse rules when you find yourself repeating prompts in chat

## Instruction File Best Practices

When creating instruction files in `.github/instructions/`:

- **Focus on a single domain** - Each file should cover one specific area of concern
- **Keep files manageable** - Aim for under 300-400 lines to maintain readability
- **Use clear, descriptive filenames** - Make the scope obvious from the filename
- **Include concrete examples** - Show both correct and incorrect implementations
- **Group related concepts** - Organize content logically within the file
- **Split when necessary** - If a file grows too large, consider breaking it into focused sub-topics

## File Organization

- Use consistent naming patterns for related instruction files
- Apply the `applyTo` frontmatter to specify which files the instructions apply to
- Consider creating multiple focused files rather than one comprehensive file
- Reference other instruction files when concepts overlap

## Quality Standards

- Write instructions as you would write clear internal documentation
- Be specific and actionable rather than vague
- Include validation rules and examples where helpful
- Test instructions with real use cases to ensure clarity