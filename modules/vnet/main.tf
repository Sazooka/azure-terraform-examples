########################################
# Virtual Network
########################################
resource "azurerm_resource_group" "this" {
  name                = "${var.env}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
 tags = merge(
    var.common_tags,
    {
      Name = "${var.env}-Vnet"
    }
  )
}