data "azurerm_resource_group" "rg" {
  name = "rgs"
}
resource "azurerm_storage_account" "sa" {
  name                     = var.sas
  location                 = data.azurerm_resource_group.rg.location
  resource_group_name      = data.azurerm_resource_group.rg.name
  account_replication_type = "LRS"
  account_tier             = "Standard"
}
