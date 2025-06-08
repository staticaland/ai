---
applyTo: "**/*.tf,**/*.tfvars,**/*.tfvars.json"
---

# Terraform Security Best Practices

Focused guidelines for implementing security best practices in Terraform configurations.

## Sensitive Data Handling

For detailed guidance on handling sensitive data and secrets, see the dedicated [terraform-sensitive-data.instructions.md](terraform-sensitive-data.instructions.md) file.

## Resource Security Configuration

### Encryption at Rest

```hcl
# S3 Bucket with encryption
resource "aws_s3_bucket" "secure" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_server_side_encryption_configuration" "secure" {
  bucket = aws_s3_bucket.secure.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.bucket_key.arn
    }
    bucket_key_enabled = true
  }
}

# EBS Volume with encryption
resource "aws_ebs_volume" "secure" {
  availability_zone = var.availability_zone
  size              = var.volume_size
  encrypted         = true
  kms_key_id        = aws_kms_key.ebs_key.arn

  tags = local.common_tags
}

# RDS with encryption
resource "aws_db_instance" "secure" {
  storage_encrypted   = true
  kms_key_id         = aws_kms_key.rds_key.arn
}
```

### Encryption in Transit

```hcl
# Application Load Balancer with SSL
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

# ElastiCache Redis with TLS
resource "aws_elasticache_replication_group" "secure" {
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auth_token                = var.redis_auth_token
}
```

## IAM Security Best Practices

### Least Privilege Principle

```hcl
# Specific policy with minimal permissions
resource "aws_iam_policy" "s3_read_only" {
  name = "${var.project_name}-s3-read-only"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.main.arn,
          "${aws_s3_bucket.main.arn}/*"
        ]
      }
    ]
  })
}

# Instance profile with limited permissions
resource "aws_iam_instance_profile" "app" {
  name = "${var.project_name}-app-profile"
  role = aws_iam_role.app.name
}
```

### Secure Service Roles

```hcl
resource "aws_iam_role" "app" {
  name = "${var.project_name}-app-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" = var.aws_region
          }
        }
      }
    ]
  })

  tags = local.common_tags
}
```

## Network Security

### Security Groups

```hcl
resource "aws_security_group" "web" {
  name_prefix = "${var.project_name}-web-"
  vpc_id      = var.vpc_id

  # Ingress rules - be specific
  ingress {
    description = "HTTPS from approved sources"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    description     = "HTTP from ALB only"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  # Egress rules - be restrictive
  egress {
    description = "HTTPS to internet for updates"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-web-sg"
  })
}
```

### Network ACLs

```hcl
resource "aws_network_acl" "private" {
  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  # Allow inbound from VPC only
  ingress {
    rule_no    = 100
    protocol   = -1
    cidr_block = var.vpc_cidr
    action     = "allow"
  }

  # Allow outbound to internet for updates
  egress {
    rule_no    = 100
    protocol   = "tcp"
    from_port  = 443
    to_port    = 443
    cidr_block = "0.0.0.0/0"
    action     = "allow"
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-private-nacl"
  })
}
```

## Resource Protection

### Deletion Protection

```hcl
resource "aws_db_instance" "production" {
  deletion_protection = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "critical_data" {
  bucket = var.critical_bucket_name

  lifecycle {
    prevent_destroy = true
  }
}
```

### Backup and Recovery

```hcl
resource "aws_db_instance" "main" {
  backup_retention_period = 30
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"

  final_snapshot_identifier = "${var.project_name}-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  skip_final_snapshot       = false
}
```

## Monitoring and Logging

### Enable CloudTrail

```hcl
resource "aws_cloudtrail" "security_audit" {
  name                          = "${var.project_name}-security-trail"
  s3_bucket_name               = aws_s3_bucket.audit_logs.bucket
  include_global_service_events = true
  is_multi_region_trail        = true
  enable_logging               = true

  event_selector {
    read_write_type                 = "All"
    include_management_events       = true
    exclude_management_event_sources = []

    data_resource {
      type   = "AWS::S3::Object"
      values = ["${aws_s3_bucket.critical_data.arn}/*"]
    }
  }
}
```

### VPC Flow Logs

```hcl
resource "aws_flow_log" "vpc" {
  iam_role_arn    = aws_iam_role.flow_log.arn
  log_destination = aws_cloudwatch_log_group.vpc_flow_log.arn
  traffic_type    = "ALL"
  vpc_id          = var.vpc_id
}
```

## Security Validation

### Pre-deployment Checks

```hcl
# Validate security group rules
variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access resources"
  type        = list(string)

  validation {
    condition = alltrue([
      for cidr in var.allowed_cidr_blocks :
      cidr != "0.0.0.0/0" || contains(["dev", "sandbox"], var.environment)
    ])
    error_message = "Production environments cannot allow access from 0.0.0.0/0."
  }
}
```
