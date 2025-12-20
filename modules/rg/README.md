# Azure Resource Group

An **Azure Resource Group (RG)** is a logical container that holds related Azure resources such as virtual networks, virtual machines, storage accounts, and security components.
It provides a logical scope for **organizing resources, applying access control, managing lifecycles, and coordinating deployments.**

In Infrastructure as Code (IaC) workflows, the Resource Group is usually the first component created in a new Azure environment.
All Azure resources must belong to a Resource Group, and establishing it first provides a clear structure for managing subsequent deployments.

### Why Resource Group Design Matters

Although a Resource Group can be created easily through IaC, its **management constraints** are significant.
Some Azure services do not allow being moved across Resource Groups, while others require downtime, dependency updates, or involve operational risks.

Because of this, you should carefully determine **who needs to view or modify each service**, and how Resource Group boundaries align with your operational model.

| Service          | Required Viewer(s) | Required Editor(s)  | Movable Across RG?         |
|------------------|--------------------|---------------------|----------------------------|
| VNet             | All Teams          | Network Team        | Possible (complex/depends) |
| Subnet           | All Teams          | Network Team        | Possible (complex/depends) |
| VM               | Application Team   | Application Team    | Possible                   |
| SQL Database     | Application Team   | Data Team           | Not Allowed*               |
| Storage Account  | All Teams          | Data Team           | Possible (complex/depends) |
| Key Vault        | Application Team   | Security Team       | Not Recommended*           |
| NSG              | Network Team       | Network Team        | Possible                   |

* SQL Database: Cannot be moved; requires recreation and data migration
* Key Vault: Technically possible but extremely complex due to soft-delete features; not recommended

#### Technical Details: Subnet and Private Endpoint Dependency

Private Endpoints are deployed into a specific Subnet and obtain a private IP address from that Subnet's address range. The Private Endpoint resource maintains a reference to:

1. The Subnet ID (resource identifier)
2. The private IP address allocation
3. The Network Interface Card (NIC) created in the Subnet

**What happens when the Subnet is moved:**
```hcl
# Before move
Subnet ID: /subscriptions/.../resourceGroups/network-rg/providers/Microsoft.Network/virtualNetworks/vnet/subnets/subnet1

# After move
Subnet ID: /subscriptions/.../resourceGroups/new-network-rg/providers/Microsoft.Network/virtualNetworks/vnet/subnets/subnet1
```

The Private Endpoint's reference to the old Subnet ID becomes invalid. Azure does not automatically update these references, requiring:

1. Deletion of existing Private Endpoint
2. Recreation with the new Subnet reference
3. Update of Private DNS Zone records (if applicable)
4. Reconfiguration of any application connection strings or service endpoints

**Impact:** Downtime during recreation, potential DNS propagation delays.

### Key Design Considerations
#### 1. Access Management

Separating resources into multiple Resource Groups enables **granular RBAC (Role-Based Access Control).**

This is useful when:

- Using a single subscription but separating environments (Dev / Staging / Production)
- Delegating responsibilities across teams (Application, Infrastructure, Security, Operations)
- Enforcing least-privilege access based on organizational roles

Define clearly **which team owns which resources**, and whether access should be read-only or full control.

#### 2. Lifecycle Management

Deleting a Resource Group results in **automatic deletion of all resources inside it.**
You can leverage this behavior to group resources that share the same lifecycle, such as:

- Temporary or disposable test environments
- Experimental workloads
- Feature-specific resource bundles that can be created and deleted together

Conversely, long-lived or shared services (e.g., VNet, Key Vault, identity infrastructure) should **not** be placed in disposable RGs to avoid accidental destructive impact.

Consider whether resources should be treated as a cohesive unit before placing them inside the same Resource Group.

### Terraform Example

```hcl
resource "azurerm_resource_group" "this" {
  name     = var.rg_name
  location = var.location
}
```