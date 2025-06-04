---
mode: "agent"
tools: ["codebase"]
description: "Generate a new REST API endpoint with validation and documentation"
---

# Create API Endpoint

Your goal is to generate a new REST API endpoint following best practices for security, validation, and documentation.

## Requirements

Ask for the endpoint details if not provided:

- Endpoint path (e.g., `/api/users`)
- HTTP method (GET, POST, PUT, DELETE)
- Request/response data structure
- Authentication requirements

## Implementation Guidelines

### Security & Validation

- **Authentication**: Implement proper authentication middleware
- **Input validation**: Validate all request parameters and body data
- **Sanitization**: Sanitize user inputs to prevent injection attacks
- **Rate limiting**: Include rate limiting considerations
- **CORS**: Configure CORS headers appropriately

### Error Handling

- **Consistent error responses**: Use standardized error response format
- **HTTP status codes**: Return appropriate status codes
- **Error logging**: Log errors for monitoring and debugging
- **Graceful degradation**: Handle edge cases gracefully

### Documentation

- **OpenAPI/Swagger**: Generate API documentation
- **JSDoc comments**: Document parameters, responses, and examples
- **Type definitions**: Use TypeScript interfaces for request/response types

## Template Structure

```typescript
// Types
interface RequestBody {
  // Define request structure
}

interface ResponseData {
  // Define response structure
}

// Validation schema (using Joi, Yup, or similar)
const validationSchema = {
  // Define validation rules
};

// Controller function
export const endpointHandler = async (req: Request, res: Response) => {
  try {
    // 1. Validate input
    // 2. Authenticate/authorize
    // 3. Process business logic
    // 4. Return response
  } catch (error) {
    // Error handling
  }
};
```

## Files to Generate

1. Route handler/controller
2. Validation schemas
3. Type definitions
4. Test files
5. API documentation updates

Ensure the endpoint follows RESTful conventions and includes comprehensive error handling.
