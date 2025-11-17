# Azure Virtual Network (VNet)

Azure Virtual Network (VNet) is the private network foundation in Azure.  
This repository highlights key design considerations for VNets and provides background information to interpret the IaC templates.  

In an IaC repository, **unclear connection policies** can cause subsequent Subnet, NSG, or Firewall designs to fail.  
Therefore, please finalize the system design policy before creating IaC templates.  

In this example, we assume **internet-facing access**, with a sample VNet `10.0.0.0/20` and Azure default DNS. (See `modules/vnet/main.tf`)  

Below are **three essential design points**.
---

## 1. IP Address Planning

Azure reserves **5 IP addresses per subnet**, so the actual usable IPs are as follows:

- `/16`: Total 65,536 → Usable 65,531  
  Example: `10.0.0.0/16`
- `/20`: Total 4,096 → Usable 4,091  
  Example: `10.0.0.0/20`
- `/24`: Total 256 → Usable 251  
  Example: `192.168.11.0/24`

**Selection criteria: Consider the number of VMs, AKS pods/services, Azure Firewall, Application Gateway, or other services consuming multiple IPs.  
Note: Some services, such as **Azure Firewall**, cannot be deployed into `/26` or `/27` subnets. Plan your subnet size accordingly.
**---

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

>Note: This configuration **overrides internal VNet name resolution** and is **not related to Azure Public DNS**.


### Terraform Example
```hcl
resource "azurerm_virtual_network" "this" {
  name                = "${var.env}-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.0.0.0/20"]
  tags = merge(
    var.common_tags,
    {
      Name = "${var.env}-Vnet"
    }
  )
}l
```
