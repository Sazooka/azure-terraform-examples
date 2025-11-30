# Azure Fixed Subnet Names Reference

Some Azure services require specific, **case-sensitive subnet names**. Using incorrect names will prevent service deployment.

## Required Subnet Names

| Service | Required Subnet Name | Minimum CIDR | Recommended CIDR |
|---------|---------------------|--------------|------------------|
| Azure Firewall | `AzureFirewallSubnet` | `/26` | `/26` |
| VPN Gateway | `GatewaySubnet` | `/29` (Basic SKU) | `/27` or larger |
| Azure Bastion | `AzureBastionSubnet` | `/26` | `/27` |

## Important Notes

### Name Matching Rules

- Names are **case-sensitive** and must match exactly
- ❌ `azure-firewall-subnet` will not work
- ❌ `azurefirewallsubnet` will not work  
- ✅ `AzureFirewallSubnet` is correct

### Dedicated Use

- These subnets are **dedicated** to their respective services
- No other resources (VMs, NICs, etc.) can be deployed into these subnets
- **GatewaySubnet** must not have an NSG attached (will cause Gateway malfunction)

### SKU-Specific Requirements

**VPN Gateway:**
- Basic SKU: Minimum `/29` (8 IPs)
- Standard/HighPerformance/VpnGw SKUs: Recommended `/27` or larger
- ExpressRoute coexistence: Requires larger subnet

**Azure Bastion:**
- Standard SKU: Minimum `/26` (64 IPs)
- Recommended `/27` for better performance

## Terraform Examples

### Azure Firewall Subnet
```hcl
resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet"  # Must be exact
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/26"]
}
```

### Gateway Subnet
```hcl
resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"  # Must be exact
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.255.0/27"]
}

# Do NOT attach NSG to GatewaySubnet
```

### Azure Bastion Subnet
```hcl
resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"  # Must be exact
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.2.0/27"]
}
```

## References

- [Azure Firewall Subnet Requirements](https://learn.microsoft.com/en-us/azure/firewall/)
- [VPN Gateway Planning](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-planning-design)
- [Azure Bastion Configuration](https://learn.microsoft.com/en-us/azure/bastion/)