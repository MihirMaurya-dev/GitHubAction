module "rg" {
  source = "../Child module/rg"

  rg_name     = var.rg_name
  rg_location = var.rg_location
}

module "vnet" {
  depends_on = [module.rg]

  source = "../Child module/vnet"

  vnet_name = var.vnet_name
  rg_name   = var.rg_name
}

module "snet" {
  depends_on = [module.vnet]

  source = "../Child module/snet"

  snet_name = var.snet_name
  vnet_name = var.vnet_name
  rg_name   = var.rg_name
}

module "nic" {
  depends_on = [module.snet]

  source = "../Child module/nic"

  nic_name  = var.nic_name
  nsg_name  = var.nsg_name
  snet_name = var.snet_name
  vnet_name = var.vnet_name
  rg_name   = var.rg_name
}

module "pip" {
  depends_on = [module.rg]

  source   = "../Child module/pip"
  pip_name = var.pip_name
  rg_name  = var.rg_name
}

module "nsg" {
  depends_on = [module.rg]
  source     = "../Child module/nsg"
  nsg_name   = var.nsg_name
  rg_name    = var.rg_name
}

module "nat" {
  depends_on = [module.rg]
  source     = "../Child module/nat"
  nat_name   = var.nat_name
  rg_name    = var.rg_name
}

module "bastion" {
  depends_on   = [module.vnet]
  source       = "../Child module/bastion"
  bastion_name = var.bastion_name
  rg_name      = var.rg_name
  vnet_name    = var.vnet_name
}

module "vm" {
  depends_on     = [module.nic]
  source         = "../Child module/vm"
  vm_name        = var.vm_name
  rg_name        = var.rg_name
  nic_name       = var.nic_name
  admin_username = var.admin_username
  admin_password = var.admin_password
}

module "loadblancer" {
  depends_on = [module.rg]
  source     = "../Child module/loadblancer"
  lb_name    = var.lb_name
  rg_name    = var.rg_name
}
