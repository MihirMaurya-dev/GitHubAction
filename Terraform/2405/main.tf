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

# ==========================================
# 1. VARIABLES (List, Set, Map)
# ==========================================

# A list of strings (needs toset() for for_each)
variable "rg_list" {
  type    = list(string)
  default = ["rg-practice-list-1", "rg-practice-list-2"]
}

# A set of strings (can be used directly)
variable "rg_set" {
  type    = set(string)
  default = ["rg-practice-set-1", "rg-practice-set-2"]
}

# A map of resource group names to locations
variable "rg_map" {
  type = map(string)
  default = {
    "rg-practice-map-1" = "eastus"
    "rg-practice-map-2" = "westus"
  }
}

# ==========================================
# 2. RESOURCES (for_each loops)
# ==========================================

# Looping over a LIST (must convert with toset)
resource "azurerm_resource_group" "rg_from_list" {
  for_each = toset(var.rg_list)
  name     = each.value
  location = "eastus"
}

# Looping over a SET directly
resource "azurerm_resource_group" "rg_from_set" {
  for_each = var.rg_set
  name     = each.value
  location = "eastus"
}

# Looping over a MAP directly
resource "azurerm_resource_group" "rg_from_map" {
  for_each = var.rg_map
  name     = each.key
  location = each.value
}
