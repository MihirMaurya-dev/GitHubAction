terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.73.0"

    }
  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "rg" {
  name       = "rg-practice1"
  location   = "eastus"
  managed_by = "shahil"
}
resource "azurerm_storage_account" "name" {

  name                     = "stpract1"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}
resource "azurerm_resource_group" "rg1" {
  name       = "rg-practice2"
  location   = "eastus"
  managed_by = "shahil"
}
