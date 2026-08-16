module "rg" {
  source   = "../../module/rg"
  rg_name  = var.rg_name
  location = var.location
}

module "vnet" {
  source        = "../../module/vnet"
  vnet_name     = var.vnet_name
  location      = var.location
  rg_name       = module.rg.rg_name
  address_space = var.address_space
}
