---
applyTo: "**/*.tf,**/*.tfvars,**/*.tfvars.json"
---

# Terraform File Structure and Organization

Focused guidelines for organizing Terraform files and modules effectively.

## Standard Module Structure

### Core Files

- Start every module with a `main.tf` file where resources are located by default
- Create logical groupings of resources with descriptive filenames:
  - `variables.tf` - All variable declarations
  - `outputs.tf` - All output declarations
  - `versions.tf` - Provider and Terraform version constraints
  - `data.tf` - Data sources (if numerous)

### Logical Resource Groupings

Group related resources by function, not by resource type:

- `network.tf` - VPC, subnets, routing, NAT gateways
- `compute.tf` - EC2 instances, auto-scaling groups, launch templates
- `security.tf` - Security groups, IAM roles, policies
- `storage.tf` - S3 buckets, EBS volumes, databases
- `monitoring.tf` - CloudWatch, alarms, dashboards

### Avoid Over-Segmentation

- **Don't** give every resource its own file
- **Don't** separate by resource type (all `aws_instance` in one file)
- **Do** group by shared purpose and logical relationships

### Directory Structure

```
module/
├── main.tf              # Primary resources
├── variables.tf         # Variable definitions
├── outputs.tf          # Output values
├── versions.tf         # Provider constraints
├── data.tf             # Data sources (if many)
├── locals.tf           # Local values (if complex)
├── network.tf          # Networking resources
├── compute.tf          # Compute resources
├── security.tf         # Security-related resources
├── README.md           # Module documentation
├── examples/           # Usage examples
│   └── basic/
│       ├── main.tf
│       └── variables.tf
├── docs/               # Additional documentation
├── files/              # Static files
├── templates/          # Template files
└── scripts/            # Helper scripts
```

## File Organization Best Practices

### Resource Grouping Strategy

```hcl
# network.tf - All networking resources together
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.common_tags
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-public-${count.index + 1}"
    Type = "public"
  })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-igw"
  })
}
```

### File Header Comments

```hcl
# network.tf
#
# This file contains all networking resources including:
# - VPC and subnets
# - Internet and NAT gateways
# - Route tables and associations
# - Network ACLs
```

## Module Documentation

### README.md Structure

````markdown
# Module Name

Brief description of what this module creates.

## Usage

\```hcl
module "example" {
source = "./modules/example"

project_name = "my-project"
environment = "prod"
}
\```

## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | >= 1.0  |
| aws       | ~> 5.0  |

## Inputs

| Name         | Description         | Type     | Default | Required |
| ------------ | ------------------- | -------- | ------- | :------: |
| project_name | Name of the project | `string` | n/a     |   yes    |

## Outputs

| Name   | Description   |
| ------ | ------------- |
| vpc_id | ID of the VPC |
````

### Examples Directory

- Create `examples/` folder with working examples
- Each example should be a complete, runnable configuration
- Include different use cases: `basic/`, `advanced/`, `multi-region/`

## Local Values Organization

### locals.tf (when needed)

```hcl
# locals.tf
#
# Complex local values and calculations

locals {
  # Common tags applied to all resources
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
    CreatedAt   = timestamp()
  }

  # Derived values
  instance_name = "${var.project_name}-${var.environment}-web"

  # Conditional logic
  security_group_rules = var.environment == "prod" ? var.prod_sg_rules : var.dev_sg_rules

  # Complex transformations
  subnet_map = {
    for idx, cidr in var.subnet_cidrs :
    "subnet-${idx}" => {
      cidr = cidr
      az   = var.availability_zones[idx]
    }
  }
}
```

## Multi-Environment Organization

### Workspace-based Structure

```
environments/
├── dev/
│   ├── main.tf
│   ├── variables.tf
│   └── terraform.tfvars
├── staging/
│   ├── main.tf
│   ├── variables.tf
│   └── terraform.tfvars
└── prod/
    ├── main.tf
    ├── variables.tf
    └── terraform.tfvars
```

### Module Reference Pattern

```hcl
# environments/prod/main.tf
module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = "prod"
  vpc_cidr     = "10.0.0.0/16"
}

module "compute" {
  source = "../../modules/compute"

  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnet_ids
  environment = "prod"
}
```
