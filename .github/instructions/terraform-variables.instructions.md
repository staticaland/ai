---
applyTo: "**/*.tf,**/*.tfvars,**/*.tfvars.json"
---

# Terraform Variable Best Practices

Focused guidelines for declaring and using variables effectively in Terraform.

## Variable Declaration Standards

### Complete Variable Definition

```hcl
variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1

  validation {
    condition     = var.instance_count > 0
    error_message = "Instance count must be positive."
  }
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}
```

## Variable Guidelines

### Required Elements

- **Always** provide descriptions for variables
- **Always** specify types explicitly
- Use `validation` blocks for input validation where appropriate

### Default Value Strategy

- Provide default values for environment-independent values
- **Don't** provide defaults for environment-specific values (`project_id`, `region`)
- Use empty defaults only when leaving empty is valid
- Only parameterize values that must vary between instances/environments

### Complex Variable Types

```hcl
variable "server_configs" {
  description = "Map of server configurations"
  type = map(object({
    ami           = string
    instance_type = string
    subnet_id     = string
    key_pair      = string
  }))
  default = {}
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access resources"
  type        = list(string)

  validation {
    condition = alltrue([
      for cidr in var.allowed_cidr_blocks : can(cidrhost(cidr, 0))
    ])
    error_message = "All CIDR blocks must be valid."
  }
}
```

## Variable Organization

### File Structure

- Keep all variable declarations in `variables.tf`
- Group related variables together
- Order variables logically (required first, then optional)
- Use comments to separate logical groups

### Variable Grouping Example

```hcl
# Infrastructure Configuration
variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

# Network Configuration
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

# Compute Configuration
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
```

## Sensitive Variables

### Handling Sensitive Data

```hcl
variable "database_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "api_keys" {
  description = "Map of API keys"
  type        = map(string)
  sensitive   = true
  default     = {}
}
```

### Best Practices for Secrets

- Mark sensitive variables with `sensitive = true`
- Never provide default values for secrets
- Use external secret management systems when possible
- Reference secrets through data sources rather than variables when feasible
