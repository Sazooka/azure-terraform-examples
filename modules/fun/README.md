# Azure Functions

Azure Functions is a serverless compute service designed to execute small units of logic based on specific triggers.
In this repository, Functions are treated not as a feature, but as a design choice

## 1. When to Choose Azure Functions

Azure provides multiple compute options such as Virtual Machines, Container Apps, and App Service.
This repository prioritizes Azure Functions when:
The required logic can be executed in small, independent units
Infrastructure management should be minimized
Execution is triggered by events, requests, or schedules
Always-on compute is not required

If the system can be implemented without managing servers or containers,
Azure Functions is preferred as the default option.

## 2.What This Repository Provides

This repository defines the infrastructure layer for Azure Functions using Terraform.

Function App
Hosting plan (Consumption)
Storage Account (required for Functions)
Managed Identity (if applicable)

Application code and actual use cases are implemented in a separate repository.


### Environment-Specific Considerations

Address space requirements often differ by environment:

- **Development:** May require broader address space (e.g., `/16`) to support multiple VNets for team isolation, PoCs, and experimental services. Azure Firewall is often omitted to reduce costs.
- **Staging/Production:** Should use **consistent CIDR sizing** (e.g., both `/20`) to ensure configuration parity and simplify deployment validation. Include all production services in Staging for realistic testing.

**Design Tip:** Align Staging and Production VNet sizes to avoid network configuration discrepancies during deployments.

---


## 2. Connection Sources & Paths

The structure of the VNet depends on **who accesses it and from where**.  
Main connection patterns:

- Internet-facing (via public endpoints)
- On-premises network (via VPN / ExpressRoute)
- Other VNets (via VNet Peering)
- Private endpoint only (closed network)
- Zero-trust design with Azure AD + Private Access

These patterns significantly affect Subnet layout, NSG rules, Firewall configuration, and Private Endpoint requirements.

---

## 3. DNS Server Placement
The `dns_servers` property in a VNet is used when **custom DNS servers** are required, such as:

- On-premises AD DNS integration
- Self-managed DNS VMs

**Key considerations:**

- Is Azure default DNS (`168.63.129.16`) sufficient?
- Is integration with on-premises AD DNS required?
- Do you need to operate your own DNS VMs?

**Note:** This configuration **overrides internal VNet name resolution** and is **not related to Azure Public DNS**.


### Terraform Example
**modules/vnet/main.tf:**
```hcl
resource "azurerm_virtual_network" "this" {
  name                = "${var.env}-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.vnet_address_space
  
  tags = merge(
    var.common_tags,
    {
      name = "${var.env}-vnet"
    }
  )
}
```

**env/dev/dev.tfvars:**
```hcl
env                = "dev"
location           = "japaneast"
vnet_address_space = ["10.0.0.0/16"]  # Broader for experimentation
```

**env/stg/stg.tfvars:**
```hcl
env                = "stg"
location           = "japaneast"
vnet_address_space = ["10.1.0.0/20"]  # Matches production sizing
```

**env/prod/prod.tfvars:**
```hcl
env                = "prod"
location           = "japaneast"
vnet_address_space = ["10.2.0.0/20"]  # Same size as staging
```

**Benefits:**
- Environment-specific CIDR ranges without modifying module code
- Clear separation of configuration (`.tfvars`) and implementation (`.tf`)
- Easy addition of new environments while maintaining consistency