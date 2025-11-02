# Terraform Tagging Guidelines

This guide introduces the most common tagging patterns for Terraform configurations.  
Each example is simple and ready to use, so you can copy and adapt them directly in your environment.

## Resource-Level Tags
When creating Azure resources, apply consistent tags to help with identification, cost tracking, and environment separation.

### Example: Resource Group

```hcl
resource "azurerm_resource_group" "this" {
  name    = "${var.env}-Rg"
  location   = var.location
  tags = {
      "Name" = "${var.env}-Rg"
  }
}
```
Next Steps:
In future updates, we’ll include examples for environment-wide and project-level tags to ensure consistency across all modules.

