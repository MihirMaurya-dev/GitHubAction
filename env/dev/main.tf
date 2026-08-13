# Parent Module: Resource Group (abhay_rg)
module "abhay_rg" {
  source   = "../../module/rg"
  rg_name  = var.rg_name
  location = var.location
}

# Child Module 1: Virtual Network (abhay_vnet) - depends on Resource Group
module "abhay_vnet" {
  source        = "../../module/vnet"
  vnet_name     = var.vnet_name
  location      = var.location
  rg_name       = module.abhay_rg.rg_name
  address_space = var.address_space
  
  depends_on = [module.abhay_rg]
}

# Child Module 2: Subnet (abhay_subnet) - depends on Virtual Network
module "abhay_subnet" {
  source            = "../../module/subnet"
  subnet_name       = var.subnet_name
  rg_name           = module.abhay_rg.rg_name
  vnet_name         = module.abhay_vnet.vnet_name
  address_prefixes  = var.address_prefixes
  
  depends_on = [module.abhay_vnet]
}
