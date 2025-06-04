---
mode: "agent"
tools: ["codebase"]
description: "Generate a new component with proper structure and TypeScript types"
---

# Create Component

Your goal is to generate a new component based on the existing project structure and patterns.

## Requirements

Ask for the component name and type if not provided. Generate the component with:

- **Proper file structure**: Follow the existing project's component organization
- **TypeScript types**: Define interfaces for props and any complex data structures
- **Modern patterns**: Use functional components with hooks (React) or composition API (Vue)
- **Styling**: Include basic styling structure (CSS modules, styled-components, or project's preferred method)
- **Documentation**: Add JSDoc comments and usage examples
- **Testing**: Create a basic test file for the component

## Template Structure

```typescript
// Component interface
interface ComponentProps {
  // Define props here
}

// Main component
export const ComponentName: React.FC<ComponentProps> = ({ }) => {
  // Component logic
  return (
    // JSX/Template
  );
};

export default ComponentName;
```

## Additional Files to Generate

1. Component file (`.tsx` or `.vue`)
2. Styles file (`.module.css`, `.styled.ts`, etc.)
3. Test file (`.test.tsx` or `.spec.ts`)
4. Index file for exports (if following barrel export pattern)

Ensure the component follows accessibility best practices and is responsive by default.
