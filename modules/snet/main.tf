########################################
# Subnet
########################################
resource "azurerm_subnet" "this"{
  for_each = var.subnet_definitions
    name                  = "${var.env}-Snet-${each.key}"
    resource_group_name   = var.resource_group_name
    virtual_network_name  = var.vnet_name
    address_prefixes     = [each.value.address_prefixes]
    dynamic "delegation" {
        for_each = each.value.delegation_service != null ? [each.value] : []
        content {
          name = delegation.value.delegation_name
          service_delegation {
            name    = delegation.value.delegation_service
            actions = delegation.value.delegation_actions
        }
    }
 }
}
/*
resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = {
    for k, v in var.subnet_definitions : k => v
    if try(v.nsg_key, null) != null
  }

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = module.nsg[each.value.nsg_key].id
}
*/

########################################
# Outputs
########################################
########################################
# Outputs
########################################
output "subnet_ids" {
  description = "Map of subnet IDs by key"
  value       = { for k, v in azurerm_subnet.this : k => v.id }
}

output "subnet_names" {
  description = "Map of subnet names by key"
  value       = { for k, v in azurerm_subnet.this : k => v.name }
}

