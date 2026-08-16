data "azurerm_resource_group" "rg" {
  name = "rgs"
}
data "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  resource_group_name = data.azurerm_resource_group.rg.name
}
resource "azurerm_subnet" "snet" {
  name                 = var.snets
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
  address_prefixes     = [var.address_prefix]
}
