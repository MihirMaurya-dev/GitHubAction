variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "East US"
}

variable "prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "practice"
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefix" {
  description = "Address prefix for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "storage_account_name" {
  description = "Name of the Storage Account (must be globally unique, lowercase, 3-24 chars)"
  type        = string
}
