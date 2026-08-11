variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "location" {
  description = "Location of the virtual network"
  type        = string
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "address_space" {
  description = "Address space of the virtual network"
  type        = list(string)
}
