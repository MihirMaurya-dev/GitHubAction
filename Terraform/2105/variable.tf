variable "resource_group_name" {
  type        = string
  description = "The name of the Azure Resource Group"
  default     = "mihir-2105"
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be deployed"
  default     = "eastus"

  validation {
    condition     = contains(["eastus", "eastus2", "westus", "centralus"], var.location)
    error_message = "The location must be one of: eastus, eastus2, westus, centralus."
  }
}

variable "storage_account_name" {
  type        = string
  description = "The name of the Azure Storage Account. Must be unique globally, 3-24 characters, lowercase alphanumeric."
  default     = "st2105mihir"

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "The storage account name must be 3-24 characters, lowercase letters, and numbers only."
  }
}

variable "container_name" {
  type        = string
  description = "The name of the Blob Storage container"
  default     = "container2105"
}

variable "account_tier" {
  type        = string
  description = "Storage Account performance tier (Standard or Premium)"
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Storage Account replication type (LRS, GRS, RA-GRS, ZRS, etc.)"
  default     = "LRS"
}
