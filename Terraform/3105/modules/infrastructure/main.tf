# 1. Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.base_name}-rg"
  location = var.location
}

# 2. Storage Account
resource "azurerm_storage_account" "storage" {
  name                     = replace("${var.base_name}sa", "-", "") # Storage names can't have hyphens
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# 3. Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.base_name}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space
}

# 4. Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.base_name}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefix
}
