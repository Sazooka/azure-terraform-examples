########################################
#Resource Group
########################################
resource "azurerm_resource_group" "this" {
  name    = "${var.env}-Rg"
  location   = var.location
  tags = {
      "Name" = "${var.env}-Rg"
  }
}