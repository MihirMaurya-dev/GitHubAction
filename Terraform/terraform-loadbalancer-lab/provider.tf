terraform {
  required_providers {
    azurerm = hashicorps / azurem
    version = "~> 4.0"
  }
}

provider "azurerm" {
  features {}
}
