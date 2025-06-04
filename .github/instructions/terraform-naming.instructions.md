---
applyTo: "**/*.tf,**/*.tfvars,**/*.tfvars.json"
---

# Terraform Naming Conventions

Focused guidelines for consistent naming in Terraform configurations.

## Resource and Variable Names

### Underscore Delimiters
Use **underscores** to delimit multiple words in configuration objects:

```hcl
resource "aws_instance" "web_server" {  # ✓ Correct
  name = "web-server"
}

resource "aws_instance" "web-server" {  # ✗ Incorrect
  name = "web-server"
}
```

### Resource Naming Rules
- Make resource names **singular** and descriptive
- For single resources of a type, use `main` as the resource name
- Don't repeat the resource type in the resource name:
  ```hcl
  resource "aws_s3_bucket" "main" { }           # ✓ Correct
  resource "aws_s3_bucket" "main_s3_bucket" { } # ✗ Incorrect
  ```
- Use meaningful names for multiple resources: `primary`, `secondary`, etc.

### Variable Naming Standards
- Include **units** in variable names for numeric values: `disk_size_gb`, `memory_size_mb`
- Use binary prefixes (1024) for storage: `kibi`, `mebi`, `gibi`
- Use decimal prefixes (1000) for other measurements: `kilo`, `mega`, `giga`
- Use positive boolean names: `enable_monitoring`, `create_backup`

## Examples

### Good Variable Names
```hcl
variable "instance_count" { }
variable "disk_size_gb" { }
variable "memory_size_mb" { }
variable "enable_monitoring" { }
variable "create_backup" { }
```

### Good Resource Names
```hcl
resource "aws_instance" "web_server" { }
resource "aws_s3_bucket" "main" { }
resource "aws_db_instance" "primary" { }
resource "aws_db_instance" "secondary" { }
```

### Tag Naming
```hcl
locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}
``` 