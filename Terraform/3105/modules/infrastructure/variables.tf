variable "base_name" {
  type        = string
  description = "Base name used for resources (e.g., mihir-3105)"
}

variable "location" {
  type        = string
  description = "Azure Region for the resources"
  default     = "belgiumcentral"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_address_prefix" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}
