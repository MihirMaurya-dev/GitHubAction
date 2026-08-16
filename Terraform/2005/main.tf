terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.73.0"
    }
  }
}

provider "azurerm" {

  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-static"
  location = "East US"
}

resource "azurerm_resource_group" "resource1" {
  name     = "storage-resources"
  location = "West Europe"
}

resource "azurerm_storage_account" "storage" {
  depends_on               = [azurerm_resource_group.resource1]
  name                     = "storageaccountname963"
  resource_group_name      = "storage-resources"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
