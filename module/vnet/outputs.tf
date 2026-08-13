output "vnet_id" {
  description = "The ID of the created virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "The name of the created virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_rg_name" {
  description = "The resource group name of the virtual network"
  value       = azurerm_virtual_network.vnet.resource_group_name
}
