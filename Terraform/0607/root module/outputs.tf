output "resource_group_name" {
  description = "Name of the Resource Group"
  value       = module.rg.name
}

output "resource_group_location" {
  description = "Location of the Resource Group"
  value       = module.rg.location
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = module.vnet.vnet_name
}

output "subnet_id" {
  description = "ID of the Subnet"
  value       = module.vnet.subnet_id
}

output "storage_account_name" {
  description = "Name of the Storage Account"
  value       = module.sa.storage_account_name
}

output "storage_account_primary_endpoint" {
  description = "Primary blob endpoint of the Storage Account"
  value       = module.sa.primary_blob_endpoint
}
