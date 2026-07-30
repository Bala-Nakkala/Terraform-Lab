# Terraform Quick Revision Notes

## 1. Root Module
- Main Terraform project.
- This is where we run `terraform init`, `plan`, and `apply`.
- It can call one or more child modules.
---

## 2. Child Module
- Reusable Terraform code.
- Called from the Root Module using `module`.
- Avoids writing the same code again and again.
---

## 3. Reusable Modules
- Modules created by us for reuse.
- Used across multiple projects.
- Example:
  - EC2 Module
  - VPC Module
  - Security Group Module
---

## 4. Public Modules
- Modules created by the Terraform community.
- Downloaded from the Terraform Registry.
- Example:
```
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
}
```
---

## 5. count
- Creates multiple identical resources.
- Uses index (0,1,2...).

Example:

```
count = 3
```

Creates:

```
EC2-1
EC2-2
EC2-3
```

---

## 6. for_each
- Creates multiple unique resources.
- Uses keys instead of indexes.

Example:

```
frontend
backend
database
```

---

## 7. Variables
- User input.
- Makes code reusable.

Example:

```
instance_type = "t3.micro"
```

---

## 8. Outputs
- Displays resource information.

Example:

```
Public IP
Instance ID
```
---

## 9. Locals
- Stores common values.
- Avoids repeating the same code.

Example:
```
Environment = dev
Owner = Balu
Project = Terraform-Lab
```

Used for common tags.

---

## 10. Data Source
- Reads existing AWS resources.
- Does NOT create resources.

Example:
- Existing AMI
- Existing VPC
- Existing Subnet

---

## 11. Drift
- Changes made manually in AWS Console.
- Terraform configuration and AWS become different.

Example:
```
Terraform
t3.micro

↓

AWS Console

t3.small
```

---

## 12. Refresh
- Terraform checks AWS and compares it with the State File.
- Detects Drift.

Usually happens during:

```
terraform plan
```

---

## 13. Workspace
- Creates multiple environments.
- Same code.
- Different State Files.

Example:
```
default
dev
qa
prod
```

---

# Remote Backend

## S3 Backend
- Stores Terraform State remotely.
- Used for team collaboration.

Without S3

```
Laptop

terraform.tfstate
```

With S3

```
Terraform

↓

S3

terraform.tfstate
```

---

## DynamoDB State Locking
- Prevents multiple users from modifying the same State File.
- Only one user can run Terraform at a time.

Flow:

```
terraform apply

↓

Acquire Lock

↓

Update State (S3)

↓

Release Lock
```

---

# count vs for_each

count

- Identical resources
- Uses index

for_each

- Unique resources
- Uses keys

---

# Variable vs Local

Variable

- User input

Local

- Internal reusable value

---

# Resource vs Data Source

Resource

- Creates infrastructure

Data Source

- Reads existing infrastructure

---

# Root Module vs Child Module

Root Module

- Main project

Child Module

- Reusable code

---

# S3 vs DynamoDB

S3

- Stores State File

DynamoDB

- Stores State Lock
---

## Terraform State File Recovery

### Scenario 1 - Local State File Deleted

```
terraform.tfstate ❌ Deleted
```

Recovery:

- Restore `terraform.tfstate.backup` (if available).
- If no backup exists, use `terraform import` to rebuild the state.

---

### Scenario 2 - Remote Backend (S3)

```
S3
│
└── terraform.tfstate
```

If the local state file is deleted:

- Run `terraform init`
- Terraform downloads the latest state from the S3 backend.

---

### Scenario 3 - S3 State File Deleted

Recovery:

- Restore the previous version (S3 Versioning enabled).
- If no backup exists, use `terraform import`.

---

## Terraform Import

### What is Import?

`terraform import` is used to bring an **existing AWS resource** under Terraform management.

- ✅ Does NOT create a resource.
- ✅ Does NOT modify a resource.
- ✅ Adds the resource to the Terraform State.

Syntax:

```
terraform import RESOURCE_NAME RESOURCE_ID
```

Example:

```
terraform import aws_instance.web i-08018d17378d175ed
```

---

### When do we use Import?

- Existing AWS resources created manually.
- Terraform State file is lost.
- Migrating existing infrastructure to Terraform.

---

### Interview One-Liner

> `terraform import` is used to import an existing cloud resource into the Terraform State. It does not create or modify the resource.

# Easy Interview One-Liners

**Root Module**
> Main Terraform project where execution starts.

**Child Module**
> Reusable Terraform code called by the Root Module.

**count**
> Creates multiple identical resources.

**for_each**
> Creates multiple unique resources.

**Locals**
> Stores common reusable values.

**Data Source**
> Reads existing AWS resources.

**Drift**
> Manual changes made outside Terraform.

**Refresh**
> Detects Drift by comparing AWS with the State File.

**Workspace**
> Same code, different environments, separate State Files.

**S3 Backend**
> Stores Terraform State remotely.

**DynamoDB**
> Prevents multiple users from updating the State File simultaneously.

Complete Terraform Project Structure
terraform-aws-infrastructure/
│
├── README.md
├── .gitignore
├── provider.tf
├── versions.tf
├── backend.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── main.tf
│
├── modules/
│   │
│   ├── vpc/
│   │     ├── main.tf
│   │     ├── variables.tf
│   │     ├── outputs.tf
│   │     └── README.md
│   │
│   ├── security-group/
│   │     ├── main.tf
│   │     ├── variables.tf
│   │     ├── outputs.tf
│   │     └── README.md
│   │
│   ├── ec2/
│   │     ├── main.tf
│   │     ├── variables.tf
│   │     ├── outputs.tf
│   │     └── README.md
│   │
│   ├── iam/
│   │     ├── main.tf
│   │     ├── variables.tf
│   │     ├── outputs.tf
│   │     └── README.md
│   │
│   └── s3/
│         ├── main.tf
│         ├── variables.tf
│         ├── outputs.tf
│         └── README.md
│
├── diagrams/
│     ├── architecture.png
│     └── workflow.png
│
└── interview-notes.md
