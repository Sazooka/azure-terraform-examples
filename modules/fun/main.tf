########################################
# Virtual Network
########################################
resource "azurerm_virtual_network" "this"{
  name                = "${var.env}-Vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space

 tags = merge(
    var.common_tags,
    {
      Name = "${var.env}-Vnet"
    }
  )
}

########################################
# Outputs
########################################
output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = azurerm_virtual_network.this.name
}

output "vnet_address_space" {
  description = "Address space of the Virtual Network"
  value       = azurerm_virtual_network.this.address_space
}

output "vnet_location" {
  description = "Location of the Virtual Network"
  value       = azurerm_virtual_network.this.location
}