## Azure Resource Group

Azure Resource Group

An Azure Resource Group is a container that holds related Azure resources, such as virtual networks, storage accounts, and virtual machines.
It allows you to manage and organize resources as a single unit.

In Infrastructure as Code (IaC) workflows, the Resource Group is typically the first resource you create in a new Azure environment.
All other resources, such as networks or storage accounts, must belong to a Resource Group.
By creating it first, you define a clear structure for managing and deploying the rest of your Azure infrastructure.

### Terraform Example

```hcl
resource "azurerm_resource_group" "this" {
  name     = var.rg_name
  location = var.location
}
```