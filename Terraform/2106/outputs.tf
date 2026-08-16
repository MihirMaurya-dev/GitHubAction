output "load_balancer_public_ip" {
  description = "Public IP of the Load Balancer — open this in your browser"
  value       = azurerm_public_ip.lb_pip.ip_address
}

output "vm_private_ip" {
  description = "Private IP address of the Virtual Machine"
  value       = azurerm_network_interface.nic.private_ip_address
}

output "vm_name" {
  description = "Name of the deployed Virtual Machine"
  value       = azurerm_linux_virtual_machine.vm.name
}

output "resource_group_name" {
  description = "Name of the Resource Group"
  value       = azurerm_resource_group.rg.name
}
