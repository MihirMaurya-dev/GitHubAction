output "subnet_id" {
  description = "The ID of the created subnet"
  value       = azurerm_subnet.subnet.id
}

output "subnet_name" {
  description = "The name of the created subnet"
  value       = azurerm_subnet.subnet.name
}

output "subnet_address_prefixes" {
  description = "The address prefixes of the subnet"
  value       = azurerm_subnet.subnet.address_prefixes
}
