output "vm_public_ip" {
  description = "Public IP address of the VM — use this to SSH into the machine"
  value       = azurerm_public_ip.vm_pip.ip_address
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

output "ssh_command" {
  description = "Command to SSH into the VM"
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.vm_pip.ip_address}"
}
