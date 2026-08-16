output "resource_group_id" {
  value       = module.my_infrastructure.resource_group_id
  description = "The ID of the Resource Group created."
}

output "vnet_id" {
  value       = module.my_infrastructure.vnet_id
  description = "The ID of the Virtual Network created."
}

output "subnet_id" {
  value       = module.my_infrastructure.subnet_id
  description = "The ID of the Subnet created."
}
