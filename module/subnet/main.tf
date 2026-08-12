resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_prefixes
}
