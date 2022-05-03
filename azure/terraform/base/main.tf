resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}RG"
  location = var.location
  tags     = {
    Environment = "pilot"
    Team = "Shanghai"
  }
}
