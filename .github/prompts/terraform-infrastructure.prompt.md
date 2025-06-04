---
mode: "agent"
tools: ["codebase"]
description: "Create and manage Terraform infrastructure with best practices"
---

# Terraform Infrastructure

Your goal is to create, modify, or manage Terraform infrastructure following best practices and standards outlined in the `.github/terraform.instructions.md` file.

## Requirements

Ask for infrastructure details if not provided:

- **Cloud provider** (AWS, Azure, GCP, etc.)
- **Resources needed** (compute, storage, networking, etc.)
- **Environment** (dev, staging, prod)
- **Region/location** preferences
- **Specific requirements** (high availability, security, compliance)

## Implementation Guidelines

### File Organization

- Follow standard module structure with logical file groupings
- Use descriptive filenames: `network.tf`, `compute.tf`, `security.tf`
- Separate variables, outputs, and provider configurations
- Include comprehensive documentation

### Resource Configuration

- Use consistent naming conventions with underscores
- Implement proper resource tagging and labeling
- Enable deletion protection for stateful resources
- Follow security best practices (encryption, least privilege)
- Use data sources for environment-specific values

### Variable Management

- Include units in numeric variable names (`disk_size_gb`)
- Provide descriptions and validation rules
- Set appropriate default values
- Use positive boolean naming (`enable_monitoring`)

### Code Quality

- Format with `terraform fmt` standards
- Use local values for complex expressions
- Implement proper error handling
- Add meaningful comments for complex logic

## Template Structure

```hcl
# versions.tf
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# variables.tf
variable "environment" {
  description = "Environment name"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

# locals.tf
locals {
  common_tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

# main.tf
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-vpc"
  })
}

# outputs.tf
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}
```

## Security Considerations

- Never hardcode sensitive values
- Use external secret management
- Enable encryption at rest and in transit
- Implement network segmentation
- Follow least privilege principles
- Enable audit logging

## Files to Generate

1. **Core Configuration Files**:

   - `versions.tf` - Provider versions and constraints
   - `variables.tf` - Input variables with validation
   - `main.tf` - Primary resources
   - `outputs.tf` - Output values
   - `locals.tf` - Local values (if needed)

2. **Resource-Specific Files** (as needed):

   - `network.tf` - VPC, subnets, routing
   - `compute.tf` - Instances, auto-scaling
   - `security.tf` - Security groups, IAM
   - `storage.tf` - Databases, storage buckets
   - `data.tf` - Data sources

3. **Documentation and Examples**:

   - `README.md` - Module documentation
   - `examples/` - Usage examples
   - `terraform.tfvars.example` - Example variables

4. **Supporting Files**:
   - `.terraform-version` - Terraform version
   - `.gitignore` - Git ignore patterns
   - `Makefile` - Common commands (optional)

## Validation and Testing

Before providing the infrastructure code:

- Validate syntax and logic
- Check for security best practices
- Ensure proper resource dependencies
- Verify naming conventions
- Test with `terraform plan` when possible

## Common Patterns

### Multi-Environment Setup

```hcl
# Use workspace or separate directories
# Include environment-specific variable files
# Use consistent naming across environments
```

### Module Composition

```hcl
# Create reusable modules for common patterns
# Use module composition for complex infrastructure
# Follow single responsibility principle
```

### State Management

```hcl
# Configure remote backend
# Use state locking
# Implement proper backup strategies
```

Ensure all generated Terraform code is production-ready, secure, and follows infrastructure as code best practices.
