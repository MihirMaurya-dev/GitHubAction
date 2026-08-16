output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "The name of the Resource Group created."
}

output "storage_account_id" {
  value       = azurerm_storage_account.sa.id
  description = "The ID of the Storage Account created."
}

output "storage_primary_blob_endpoint" {
  value       = azurerm_storage_account.sa.primary_blob_endpoint
  description = "The primary blob endpoint of the storage account."
}
