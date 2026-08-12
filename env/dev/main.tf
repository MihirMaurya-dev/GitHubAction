module "rg" {
  source   = "../../module/rg"
  rg_name  = var.rg_name
  location = var.location
}

module "vnet" {
  source        = "../../module/vnet"
  vnet_name     = var.vnet_name
  location      = var.location
  rg_name       = var.rg_name
  address_space = var.address_space
}

module "subnet" {
  source          = "../../module/subnet"
  depends_on      = [module.vnet]
  subnet_name     = var.subnet_name
  rg_name         = var.rg_name
  vnet_name       = var.vnet_name
  address_prefixes = var.subnet_prefixes
}
