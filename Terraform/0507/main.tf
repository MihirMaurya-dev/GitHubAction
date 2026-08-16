module "resource_group" {
  source   = "./modules/resource_group"
  name     = var.rg_name
  location = var.location
}

module "storage_account" {
  source              = "./modules/storage_account"
  name                = var.storage_account_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}
