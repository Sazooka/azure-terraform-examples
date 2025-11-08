# Terraform Tagging Guidelines

This guide introduces the most common tagging patterns for Terraform configurations.  
Each example is simple and ready to use, so you can copy and adapt them directly in your environment.

## 1.Tag Levels (Concept)
Terraform tags can be applied at different levels to organize and manage Azure resources effectively.

### Resource-Level Tags
When creating Azure resources, apply consistent tags to help with identification, cost tracking, and environment separation.

#### Example: Resource Group

```hcl
resource "azurerm_resource_group" "this" {
  name    = "${var.env}-Rg"
  location   = var.location
  tags = {
      "Name" = "${var.env}-Rg"
  }
}
```

### Common / Shared Tags
Common tags are applied to all resources across environments to ensure consistency and simplify management.
These are defined in a locals.tf file at the root of your Terraform project.

Next Steps:
In future updates, we’ll include examples for environment-wide and project-level tags to ensure consistency across all modules.

#### Example
```hcl
locals {
  common_tags = {
    Project   = "TerraformDemo"
    ManagedBy = "Terraform"
  }
}
```

### Environment-Level Tags
Environment-level tags provide metadata specific to a deployment environment (e.g., dev, staging, production).
They help filter and report resources by environment.
#### Example
```hcl
locals {
  env_tags = {
    Environment = "dev"
  }
}
```

## 2.Terraform Implementation
Terraform Implementation
The following examples show how to implement these tag levels using Terraform locals and the merge function.

### Defining Locals
```hcl
locals {
  # Common / Project-level Tags
  common_tags = {
    Project   = "TerraformDemo"
    ManagedBy = "Terraform"
  }

  # Environment-level Tags
  env_tags = {
    Environment = "dev"
  }

  # Merged Tags (to apply both common and environment tags)
  merged_tags = merge(local.common_tags, local.env_tags)
}
```

### Exsample Applying Tags to a Resource Group

```hcl
resource "azurerm_resource_group" "this" {
  name     = "${var.env}-Rg"
  location = var.location

  tags = merge(
    local.common_tags,
    local.env_tags,
    {
      Name = "${var.env}-Rg"
    }
  )
}
```

## Notes

- **Conceptual separation:**  
  Understand which tags belong to which level (resource, environment, or project). This helps in planning and maintaining consistent tagging.

- **Implementation:**  
  Use Terraform `locals` and the `merge` function to apply both common (project-level) and environment-specific tags consistently to your resources.
