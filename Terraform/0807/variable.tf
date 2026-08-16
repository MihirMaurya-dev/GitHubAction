variable "rg" {
  description = "The name of the Resource Group"
  type        = string
}

variable "l" {
  description = "The Azure Region/Location"
  type        = string
}

variable "env" {
  description = "The environment tag (e.g., dev, prod)"
  type        = string
}

variable "vnet" {
  description = "The Virtual Network name"
  type        = string
}

variable "vnet_as" {
  description = "The Address Space for the VNet"
  type        = string
}

variable "subnet" {
  description = "The Subnet name"
  type        = string
}

variable "subnet_as" {
  description = "The Address Prefix for the Subnet"
  type        = string
}

variable "nsg" {
  description = "The Network Security Group name"
  type        = string
}

variable "nsg_rule" {
  description = "The NSG Rule name"
  type        = string
}

variable "nsg_rule_port" {
  description = "The destination port to open"
  type        = string
}

variable "pip" {
  description = "Public IP name"
  type        = string
}

variable "nic" {
  description = "Network Interface name"
  type        = string
}

variable "vm" {
  description = "Virtual Machine name"
  type        = string
}

variable "vm_size" {
  description = "Size of the VM"
  type        = string
}

variable "vm_admin_user" {
  description = "Admin username for the VM"
  type        = string
}

variable "vm_image_publisher" {
  description = "Publisher of the OS image"
  type        = string
}

variable "vm_image_offer" {
  description = "OS Image offer"
  type        = string
}

variable "vm_image_sku" {
  description = "OS Image SKU"
  type        = string
}

variable "vm_admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}
