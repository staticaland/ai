---
applyTo: "**/*.tf,**/*.tfvars,**/*.tfvars.json"
---

# Terraform Instructions

Composable Terraform best practices following [Google Cloud Terraform guidelines](https://cloud.google.com/docs/terraform/best-practices/general-style-structure) and [terraform-best-practices.com](https://www.terraform-best-practices.com/).

## Core Guidelines

This instruction set is composed of focused, reusable guidelines. Each covers a specific aspect of Terraform development:

### 📁 [File Structure & Organization](./terraform-structure.instructions.md)

- Standard module structure and directory layout
- Logical resource groupings by function
- Multi-environment organization patterns
- Documentation and examples structure

### 🏷️ [Naming Conventions](./terraform-naming.instructions.md)

- Resource and variable naming standards
- Consistent naming patterns across environments
- Tag naming and organization

### 🔧 [Variable Best Practices](./terraform-variables.instructions.md)

- Variable declaration standards
- Type definitions and validation
- Default value strategies
- Sensitive variable handling

### 🔒 [Security Best Practices](./terraform-security.instructions.md)

- Sensitive data handling and secret management
- Resource security configuration (encryption, IAM)
- Network security (security groups, NACLs)
- Resource protection and monitoring

## Quick Reference

### Essential Standards

- Use **underscores** for resource names, **hyphens** for actual resource naming
- Always provide variable descriptions and types
- Group resources by function, not by type
- Enable encryption at rest and in transit for production
- Never hardcode secrets in Terraform files

### File Organization

```
module/
├── main.tf              # Primary resources
├── variables.tf         # All variables
├── outputs.tf          # All outputs
├── versions.tf         # Provider constraints
├── network.tf          # Networking resources
├── security.tf         # Security resources
└── README.md           # Documentation
```

### Code Quality

- Use `terraform fmt` for consistent formatting
- Implement input validation with `validation` blocks
- Use meaningful comments for complex logic
- Test configurations with `terraform plan`

## Additional Resources

- [Provider Configuration Best Practices](https://registry.terraform.io/browse/providers)
- [Terraform State Management](https://developer.hashicorp.com/terraform/language/state)
- [Testing Terraform Code](https://developer.hashicorp.com/terraform/tutorials/configuration-language/test)

---

_This modular approach allows you to focus on specific aspects while maintaining consistency across all Terraform projects._
