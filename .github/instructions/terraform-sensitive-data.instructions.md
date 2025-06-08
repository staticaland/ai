---
applyTo: "**/*.tf,**/*.tfvars,**/*.tfvars.json"
---

# Terraform Sensitive Data Handling

Focused guidelines for handling sensitive data and secrets in Terraform configurations.

## Never Hardcode Secrets

```hcl
# ✗ NEVER do this
resource "aws_db_instance" "bad_example" {
  password = "hardcoded-password-123"  # Extremely dangerous
}

# ✓ Use variables instead
resource "aws_db_instance" "good_example" {
  password = var.database_password
}
```

## Sensitive Variable Declaration

```hcl
variable "database_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  # Never provide a default for secrets
}

variable "api_keys" {
  description = "Map of API keys"
  type        = map(string)
  sensitive   = true
  default     = {}
}
```

## External Secret Management

```hcl
# Retrieve secrets from AWS Secrets Manager
data "aws_secretsmanager_secret" "db_password" {
  name = "prod/database/password"
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
}

resource "aws_db_instance" "main" {
  password = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["password"]
}
```

## Best Practices

- Mark sensitive variables with `sensitive = true`
- Never provide default values for secrets
- Use external secret management systems when possible
- Reference secrets through data sources rather than variables when feasible
- Store secrets in secure external systems (AWS Secrets Manager, HashiCorp Vault, etc.)
- Use separate `.tfvars` files for sensitive values and keep them out of version control