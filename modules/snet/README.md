# Azure Subnet

**Azure Subnet (snet)** is a logically separated segment within a Virtual Network (VNet).  
In subnet design, it is important to understand the service-specific constraints and dependencies, and to organize key design considerations using Terraform implementation examples. Because subnets are difficult to modify later, you must clarify the types and scale of services to be used before starting network construction.

## 1. Restrictions on Subnet Names and CIDR Ranges

Some Azure services require fixed subnet names (for example: `GatewaySubnet`, `AzureBastionSubnet`,`AzureFirewallSubnet`), and the minimum or recommended CIDR range varies by service.  
In some cases, available features change depending on the CIDR size, so consulting the official documentation for each service is essential. Below are simple examples.


## 2. Services Requiring Subnet Delegation or Not Supporting NSGs

Some services require **subnet delegation**, which dedicates the subnet exclusively to that service.

**Example: Container Apps**
```hcl
resource "azurerm_subnet" "container_apps" {
  name                 = "container-apps-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.4.0/23"]
  
  delegation {
    name = "Microsoft.App.environments"
    service_delegation {
      name = "Microsoft.App/environments"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}
```

Some subnets **do not support Network Security Groups (NSGs)**:

- **GatewaySubnet**: NSGs are not allowed (VPN/ExpressRoute Gateways will malfunction)
- **AzureFirewallSubnet**: NSGs are not recommended (Azure Firewall has built-in filtering)

---

## 3. Terraform Implementation Examples

This section provides basic subnet creation examples and patterns for defining multiple subnets using tfvars.  
When managing multiple subnets, fixed-name subnets should be used as basic examples, while others can be handled using variable definitions through tfvars to maintain implementation clarity.


### Terraform Example
**modules/snet/main.tf:**
```hcl
resource "azurerm_subnet" "sample" {
  name                 = sample-snet
  resource_group_name  = XXXXXXXXXXX
  virtual_network_name = YYYYYYYYYYY
  address_prefixes     = 10.0.2.0/24
}

resource "azurerm_subnet" "this"{
  for_each = var.subnet_definitions
    name                = "${var.env}-Snet-${each.key}"
    location            = var.location
    resource_group_name = var.resource_group_name
    address_prefixes    = [each.value.address_prefix]
}

```hcl
resource "azurerm_subnet" "subnets" {
  for_each = var.subnets
  
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = each.value.address_prefixes
  
  dynamic "delegation" {
    for_each = each.value.delegation != null ? [1] : []
    content {
      name = "delegation"
      service_delegation {
        name = each.value.delegation
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action"
        ]
      }
    }
  }
}

```

**Benefits:**
- Service-specific delegation and NSG constraints handled consistently in module design  
- Flexible subnet definitions using variables (`.tfvars`) for scalability across environments  
- Clear separation of fixed-name subnets (e.g., GatewaySubnet) and customizable subnets for maintainability  
- Easier adaptation to new Azure services without major code changes