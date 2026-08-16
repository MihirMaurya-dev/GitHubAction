output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}
