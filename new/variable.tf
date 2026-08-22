variable "base_name" {
  type        = string
  description = "Base name used for all resources (e.g., mihir-0206)"
  default     = "mihir-0206"
}

variable "location" {
  type        = string
  description = "Azure Region for the resources"
  default     = "eastus"

  validation {
    condition     = contains(["eastus", "eastus2", "westus", "centralus"], var.location)
    error_message = "The location must be one of: eastus, eastus2, westus, centralus."
  }
}
