data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
resource "azurerm_public_ip" "example" {
  name                = var.pip_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = "Static"
}
