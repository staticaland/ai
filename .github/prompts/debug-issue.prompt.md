---
mode: "agent"
tools: ["codebase", "terminalLastCommand"]
description: "Help debug and fix issues with systematic debugging approach"
---

# Debug Issue

Your goal is to help identify and fix bugs or issues in the codebase using a systematic debugging approach.

## Debugging Process

### 1. Issue Understanding

- **Reproduce the problem**: Understand the exact steps to reproduce the issue
- **Expected vs Actual**: Clarify what should happen vs what actually happens
- **Error messages**: Collect and analyze any error messages or stack traces
- **Environment**: Note the environment where the issue occurs (dev, staging, prod)

### 2. Information Gathering

- **Recent changes**: Check recent commits and changes that might be related
- **Logs analysis**: Examine application logs, browser console, or system logs
- **Dependencies**: Check if recent dependency updates might have caused issues
- **Configuration**: Verify configuration files and environment variables

### 3. Systematic Investigation

- **Isolate the problem**: Narrow down the scope to the specific component or function
- **Add logging**: Insert temporary logging to trace execution flow
- **Test assumptions**: Verify assumptions about data flow and state
- **Check edge cases**: Consider boundary conditions and edge cases

### 4. Debugging Techniques

- **Breakpoints**: Use debugger breakpoints to step through code execution
- **Console logging**: Add strategic console.log statements
- **Unit tests**: Write focused tests to isolate the problematic behavior
- **Binary search**: Comment out code sections to isolate the issue
- **Rubber duck debugging**: Explain the problem step by step

## Common Bug Categories

### Logic Errors

- Off-by-one errors in loops
- Incorrect conditional statements
- Wrong operator usage (= vs ==, && vs ||)
- Incorrect algorithm implementation

### Runtime Errors

- Null/undefined reference errors
- Type mismatches
- Async/await issues
- Resource not found errors

### Performance Issues

- Memory leaks
- Infinite loops
- Inefficient algorithms
- Unnecessary re-renders

### Integration Issues

- API communication problems
- Database connection issues
- Third-party service failures
- Configuration mismatches

## Debugging Checklist

- [ ] Can you reproduce the issue consistently?
- [ ] What are the exact error messages and stack traces?
- [ ] When did this issue first appear?
- [ ] What was changed recently that might be related?
- [ ] Have you checked the logs for additional information?
- [ ] Are there any patterns to when the issue occurs?
- [ ] Have you tested with different data or scenarios?
- [ ] Have you verified the environment configuration?

## Fix Verification

After implementing a fix:

- [ ] Verify the original issue is resolved
- [ ] Test related functionality to ensure no regressions
- [ ] Add tests to prevent the issue from recurring
- [ ] Update documentation if the issue revealed gaps
- [ ] Consider if similar issues might exist elsewhere

Provide step-by-step debugging guidance and suggest specific debugging techniques based on the type of issue encountered.
