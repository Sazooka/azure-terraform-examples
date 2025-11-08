########################################
#Resource Group
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