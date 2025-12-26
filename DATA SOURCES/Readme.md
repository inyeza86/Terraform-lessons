# Terraform AWS Data Sources & Best Practices

This repository provides guidance on using **Terraform data sources with the AWS provider**, with a focus on **production-ready modules** and **best practices**.

---

## Table of Contents

1. [Introduction](#introduction)  
2. [What are Terraform Data Sources?](#what-are-terraform-data-sources)  
3. [Common AWS Data Sources](#common-aws-data-sources)  
4. [Using Data Sources Inside Modules](#using-data-sources-inside-modules)  
5. [Best Practices for Production](#best-practices-for-production)  
6. [Recommended Repository Structure](#recommended-repository-structure)

---

## Introduction

Terraform **data sources** allow you to **read existing infrastructure** without creating or modifying it. They are commonly used to reference resources like VPCs, subnets, security groups, AMIs, and IAM roles.

---

## What are Terraform Data Sources?

- **Read-only lookups** for existing resources  
- Can reference resources **created outside Terraform** or by other modules  
- Syntax:

```hcl
data "<PROVIDER>_<TYPE>" "<NAME>" {
  # lookup arguments
}

# Example usage
data.<PROVIDER>_<TYPE>.<NAME>.<ATTRIBUTE>

## Common AWS Data Sources
Some frequently used AWS data sources include:
- `aws_vpc`
- `aws_subnet`
- `aws_ami`
- `aws_security_group`
- `aws_iam_role`
- `aws_availability_zones`
---

## AMI
```
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
```
### Example Usage
```
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
}
```
---
### VPC
```
data "aws_vpc" "prod" {
  filter {
    name   = "tag:Environment"
    values = ["prod"]
  }
}
```
### Subnets
```
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.prod.id]
  }

  filter {
    name   = "tag:Tier"
    values = ["private"]
  }
}
```

## Using Data Sources Inside Modules

When using data sources within modules: 
- Pass necessary identifiers as **input variables**
- Use data sources to **dynamically fetch resource attributes**
- Avoid hardcoding values; rely on data sources for flexibility
---
## Best Practices for Production
1. **Version Control**: Pin provider versions in `required_providers` block.
2. **Modular Design**: Encapsulate data source logic within reusable modules.
3. **Input Validation**: Use variable validation to ensure correct input types.
4. **Outputs**: Expose necessary attributes via module outputs.
5. **Documentation**: Document data sources and their purpose in module READMEs.
---
