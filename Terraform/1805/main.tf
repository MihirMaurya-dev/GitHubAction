terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.72.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "mihir_rg" {
  name     = "mihir-1"
  location = "eastus"
}

resource "azurerm_storage_account" "mihir_sa" {
  name                     = "mihirsa123"
  resource_group_name      = azurerm_resource_group.mihir_rg.name
  location                 = azurerm_resource_group.mihir_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
