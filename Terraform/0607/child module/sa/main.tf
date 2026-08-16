variable "storage_account_name" {
  description = "Name of the Storage Account (lowercase, 3-24 chars, globally unique)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

output "storage_account_name" {
  description = "Name of the Storage Account"
  value       = azurerm_storage_account.sa.name
}

output "primary_blob_endpoint" {
  description = "Primary Blob Service endpoint"
  value       = azurerm_storage_account.sa.primary_blob_endpoint
}
