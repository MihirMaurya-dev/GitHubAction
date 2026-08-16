variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

output "name" {
  description = "Resource Group name"
  value       = azurerm_resource_group.rg.name
}

output "location" {
  description = "Resource Group location"
  value       = azurerm_resource_group.rg.location
}
