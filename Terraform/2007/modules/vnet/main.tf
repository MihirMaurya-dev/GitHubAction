data "azurerm_resource_group" "rg" {
  name = "rgs"
}
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnets
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.range
}
