module "rg" {
  source              = "../child module/rg"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "vnet" {
  source = "../child module/vnet"

  prefix                = var.prefix
  location              = module.rg.location
  resource_group_name   = module.rg.name
  vnet_address_space    = var.vnet_address_space
  subnet_address_prefix = var.subnet_address_prefix
}

module "sa" {
  source = "../child module/sa"

  storage_account_name = var.storage_account_name
  location             = module.rg.location
  resource_group_name  = module.rg.name
}
