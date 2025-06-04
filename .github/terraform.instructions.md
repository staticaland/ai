---
applyTo: "**/*.tf,**/*.tfvars,**/*.tfvars.json"
---

# Terraform Instructions

This file contains specific instructions for Terraform development, incorporating best practices from [Google Cloud Terraform guidelines](https://cloud.google.com/docs/terraform/best-practices/general-style-structure) and [terraform-best-practices.com](https://www.terraform-best-practices.com/).

## File Structure and Organization

### Standard Module Structure

- Start every module with a `main.tf` file where resources are located by default
- Create logical groupings of resources with descriptive filenames:
  - `variables.tf` - All variable declarations
  - `outputs.tf` - All output declarations
  - `versions.tf` - Provider and Terraform version constraints
  - `data.tf` - Data sources (if numerous)
  - Logical groupings like `network.tf`, `compute.tf`, `security.tf`, `storage.tf`
- Avoid giving every resource its own file - group by shared purpose
- Place examples in `examples/` folder with separate subdirectories
- Include comprehensive `README.md` with module documentation
- Place additional documentation in `docs/` subdirectory
- Static files go in `files/` directory, templates in `templates/` directory
- Custom scripts in `scripts/` directory, helper scripts in `helpers/` directory

## Naming Conventions

### Resource and Variable Names

- Use **underscores** to delimit multiple words in configuration objects:

  ```hcl
  resource "aws_instance" "web_server" {  # ✓ Correct
    name = "web-server"
  }

  resource "aws_instance" "web-server" {  # ✗ Incorrect
    name = "web-server"
  }
  ```

- Make resource names **singular** and descriptive
- For single resources of a type, use `main` as the resource name
- Don't repeat the resource type in the resource name:
  ```hcl
  resource "aws_s3_bucket" "main" { }           # ✓ Correct
  resource "aws_s3_bucket" "main_s3_bucket" { } # ✗ Incorrect
  ```
- Use meaningful names for multiple resources: `primary`, `secondary`, etc.

### Variable Naming

- Include **units** in variable names for numeric values: `disk_size_gb`, `memory_size_mb`
- Use binary prefixes (1024) for storage: `kibi`, `mebi`, `gibi`
- Use decimal prefixes (1000) for other measurements: `kilo`, `mega`, `giga`
- Use positive boolean names: `enable_monitoring`, `create_backup`

## Variable Best Practices

### Variable Declaration

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

### Variable Guidelines

- **Always** provide descriptions for variables
- **Always** specify types explicitly
- Provide default values for environment-independent values
- **Don't** provide defaults for environment-specific values (`project_id`, `region`)
- Use empty defaults only when leaving empty is valid
- Only parameterize values that must vary between instances/environments
- Use `validation` blocks for input validation where appropriate

## Output Best Practices

### Output Declaration

```hcl
output "instance_ip" {
  description = "Public IP address of the instance"
  value       = aws_instance.main.public_ip
  sensitive   = false
}

output "database_endpoint" {
  description = "Database connection endpoint"
  value       = aws_db_instance.main.endpoint
  sensitive   = true
}
```

### Output Guidelines

- Provide meaningful descriptions for all outputs
- Output all useful values that consuming modules might need
- Reference resource attributes, not input variables, to create proper dependencies
- Mark sensitive outputs with `sensitive = true`
- Use consistent output naming patterns

## Resource Configuration

### Conditional Resources

Use `count` for conditional resources:

```hcl
resource "aws_instance" "optional" {
  count = var.create_instance ? 1 : 0

  ami           = var.ami_id
  instance_type = var.instance_type
}
```

### Multiple Resources

Use `for_each` for multiple similar resources:

```hcl
resource "aws_instance" "servers" {
  for_each = var.server_configs

  ami           = each.value.ami
  instance_type = each.value.type

  tags = merge(var.common_tags, {
    Name = each.key
  })
}
```

### Resource Protection

Enable deletion protection for stateful resources:

```hcl
resource "aws_db_instance" "main" {
  identifier = "main-database"

  deletion_protection = true

  lifecycle {
    prevent_destroy = true
  }
}
```

## Data Sources

### Data Source Usage

```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
}
```

### Data Source Guidelines

- Place data sources near the resources that reference them
- Move to dedicated `data.tf` if numerous
- Use interpolation to fetch environment-relative data
- Cache data sources when possible to reduce API calls

## Local Values

Use locals for complex expressions and repeated values:

```hcl
locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }

  instance_name = "${var.project_name}-${var.environment}-web"

  security_group_rules = var.environment == "prod" ? var.prod_sg_rules : var.dev_sg_rules
}
```

## Provider Configuration

### Version Constraints

```hcl
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}
```

## State Management

### Backend Configuration

```hcl
terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "infrastructure/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
```

## Code Quality and Formatting

### Formatting Standards

- Use `terraform fmt` for consistent formatting
- Limit line length to 120 characters when possible
- Use consistent indentation (2 spaces)
- Group related arguments together
- Separate logical blocks with blank lines

### Complex Expressions

- Limit complexity of interpolated expressions
- Use local values for multi-step logic
- Never use more than one ternary operation per line
- Use descriptive intermediate variables

### Comments and Documentation

```hcl
# Create VPC with public and private subnets
# This VPC will host our web application infrastructure
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-vpc"
  })
}
```

## Security Best Practices

### Sensitive Data Handling

- Never hardcode secrets in Terraform files
- Use Terraform variables for sensitive values
- Mark sensitive outputs appropriately
- Use external secret management systems (AWS Secrets Manager, etc.)

### Resource Security

- Enable encryption at rest and in transit
- Use least privilege access principles
- Implement proper network segmentation
- Enable logging and monitoring
- Follow cloud provider security best practices

## Testing and Validation

### Input Validation

```hcl
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

### Resource Validation

- Use `check` blocks for runtime validation (Terraform 1.5+)
- Implement proper error handling
- Test modules with multiple scenarios
- Use `terraform plan` to verify changes before applying

## Performance Optimization

### Resource Dependencies

- Use explicit dependencies only when necessary
- Leverage implicit dependencies through resource references
- Minimize cross-resource dependencies
- Use data sources efficiently

### Module Design

- Keep modules focused and single-purpose
- Avoid overly complex modules
- Use composition over inheritance
- Design for reusability and maintainability

## Error Handling and Debugging

### Common Issues

- State file conflicts and corruption
- Provider authentication issues
- Resource dependency cycles
- Version compatibility problems

### Debugging Techniques

- Use `TF_LOG` environment variable for detailed logging
- Enable provider logging when needed
- Use `terraform console` for expression testing
- Validate configurations with `terraform validate`

These instructions ensure Terraform code follows industry best practices for maintainability, security, and reliability.
