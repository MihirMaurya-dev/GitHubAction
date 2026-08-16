variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "ubuntu-ssh-rg"
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "West Europe"
}

variable "prefix" {
  description = "Prefix used for naming all resources"
  type        = string
  default     = "ubuntu-vm"
}

variable "vm_size" {
  description = "Size (SKU) of the Virtual Machine"
  type        = string
  default     = "Standard_DS1_v2" # 1 vCPU, 3.5 GB RAM — widely available
}

variable "admin_username" {
  description = "Admin username for SSH access to the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to your SSH public key file on your local machine"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
