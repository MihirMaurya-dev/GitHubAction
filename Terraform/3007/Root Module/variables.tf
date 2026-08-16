variable "rg_name" { type = string }
variable "rg_location" { type = string }
variable "vnet_name" { type = string }
variable "snet_name" { type = string }
variable "nic_name" { type = string }
variable "nsg_name" { type = string }
variable "pip_name" { type = string }
variable "nat_name" { type = string }
variable "bastion_name" { type = string }
variable "vm_name" { type = string }
variable "lb_name" { type = string }
variable "admin_username" { type = string }
variable "admin_password" {
  type      = string
  sensitive = true
}
