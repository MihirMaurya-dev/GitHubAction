variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "rg_name" {
  description = "Name of the resource group for the subnet"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network where the subnet will be created"
  type        = string
}

variable "address_prefixes" {
  description = "List of address prefixes for the subnet"
  type        = list(string)
}
