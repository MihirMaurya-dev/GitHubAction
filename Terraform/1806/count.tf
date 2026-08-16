terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    version = "4.75.0" }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "count_rg" {
  count    = 2
  name     = "count-rg-${count.index}"
  location = "East US"
}

resource "azurerm_resource_group" "foreach_rg" {
  for_each = toset(["rg1", "rg2"])
  name     = each.key
  location = "East US"
}
