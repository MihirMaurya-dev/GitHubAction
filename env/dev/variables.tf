variable "rg_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-dev-myapp"
}

variable "location" {
  description = "Location of the resource group"
  type        = string
  default     = "eastus"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet-dev-myapp"
}

variable "address_space" {
  description = "Address space of the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}
