resource "azurerm_resource_group" "rg" {
  name     = var.rgs
  location = var.location
}
