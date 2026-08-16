data "azurerm_resource_group" "rg" {
  name = "rgs"
}
resource "azurerm_public_ip" "pip" {
  name                = var.pips
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Standard"
  allocation_method   = "Static"
}
