# Resource Group Outputs
output "abhay_rg_id" {
  description = "The ID of the Abhay resource group"
  value       = module.abhay_rg.rg_id
}

output "abhay_rg_name" {
  description = "The name of the Abhay resource group"
  value       = module.abhay_rg.rg_name
}

output "abhay_rg_location" {
  description = "The location of the Abhay resource group"
  value       = module.abhay_rg.location
}

# Virtual Network Outputs
output "abhay_vnet_id" {
  description = "The ID of the Abhay virtual network"
  value       = module.abhay_vnet.vnet_id
}

output "abhay_vnet_name" {
  description = "The name of the Abhay virtual network"
  value       = module.abhay_vnet.vnet_name
}

# Subnet Outputs
output "abhay_subnet_id" {
  description = "The ID of the Abhay subnet"
  value       = module.abhay_subnet.subnet_id
}

output "abhay_subnet_name" {
  description = "The name of the Abhay subnet"
  value       = module.abhay_subnet.subnet_name
}

output "abhay_subnet_address_prefixes" {
  description = "The address prefixes of the Abhay subnet"
  value       = module.abhay_subnet.subnet_address_prefixes
}
