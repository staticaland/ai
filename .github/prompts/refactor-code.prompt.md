---
mode: "edit"
tools: ["codebase"]
description: "Refactor existing code for better maintainability and performance"
---

# Refactor Code

Your goal is to refactor the selected code or file to improve maintainability, performance, and code quality while preserving existing functionality.

## Refactoring Guidelines

### Code Structure

- **Single Responsibility**: Ensure each function/class has one clear purpose
- **DRY Principle**: Eliminate code duplication
- **SOLID Principles**: Apply SOLID principles where applicable
- **Consistent Patterns**: Use consistent patterns throughout the codebase
- **Proper Abstractions**: Create appropriate abstractions for complex logic

### Performance Optimization

- **Algorithm Efficiency**: Improve time and space complexity where possible
- **Memory Management**: Optimize memory usage and prevent leaks
- **Async Operations**: Use async/await properly for I/O operations
- **Caching**: Implement caching for expensive operations
- **Bundle Size**: Reduce bundle size through tree-shaking and code splitting

### Code Quality

- **Type Safety**: Improve TypeScript types and eliminate `any` types
- **Error Handling**: Add comprehensive error handling
- **Naming**: Use clear, descriptive names for variables and functions
- **Comments**: Add meaningful comments for complex logic
- **Testing**: Ensure refactored code maintains test coverage

## Refactoring Checklist

Before refactoring:

- [ ] Understand the current functionality completely
- [ ] Identify existing tests and ensure they pass
- [ ] Document the current behavior if not already documented

During refactoring:

- [ ] Make incremental changes
- [ ] Run tests after each significant change
- [ ] Maintain backward compatibility where required
- [ ] Update related documentation

After refactoring:

- [ ] Verify all tests still pass
- [ ] Update or add new tests for refactored code
- [ ] Update documentation and comments
- [ ] Check for any breaking changes

## Common Refactoring Patterns

1. **Extract Function**: Break down large functions into smaller, focused ones
2. **Extract Class**: Move related functionality into a separate class
3. **Rename**: Improve naming for better clarity
4. **Move**: Relocate code to more appropriate modules
5. **Replace Conditional with Polymorphism**: Use inheritance/interfaces instead of switch statements
6. **Introduce Parameter Object**: Group related parameters into objects

Ensure that the refactored code maintains the same external behavior while improving internal structure and quality.
