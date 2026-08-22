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

module "my_infrastructure" {
  source    = "./modules/infrastructure"
  base_name = var.base_name
  location  = var.location
}
