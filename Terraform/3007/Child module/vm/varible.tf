variable "vm_name" {}
variable "rg_name" {}
variable "nic_name" {}
variable "admin_username" {}
variable "admin_password" {
  sensitive = true
}
