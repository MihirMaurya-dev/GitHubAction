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

# Calling the module
module "my_infrastructure" {
  source = "./modules/infrastructure"

  # Passing in our variables
  base_name = "mihir-3105"
  location  = "belgiumcentral"
}
