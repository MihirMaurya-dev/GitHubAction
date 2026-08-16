variable "rg_name" {}
variable "location" {}
variable "vnet_name" {}
variable "vnet_range" {}

variable "vms" {
  type = map(object({
    snet_name   = string
    snet_prefix = string
    pip_name    = string
    nsg_name    = string
    nic_name    = string
    vm_name     = string
  }))
}
