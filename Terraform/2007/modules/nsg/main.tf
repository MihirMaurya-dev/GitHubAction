data "azurerm_resource_group" "rg" {
  name = "rgs"
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsgs
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}
