########################################
# Resource Group
########################################
resource "azurerm_resource_group" "this" {
  name    = "${var.env}-Rg"
  location   = var.location
 tags = merge(
    var.common_tags,
    {
      Name = "${var.env}-Rg"
    }
  )
}

########################################
# Outputs
########################################
output "resource_group_name" {
  description = "The name of the Resource Group"
  value       = azurerm_resource_group.this.name
}
