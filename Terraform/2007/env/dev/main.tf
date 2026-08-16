module "rg" {
  source   = "../../modules/rg"
  rgs      = var.rg_name
  location = var.location
}

module "vnet" {
  source     = "../../modules/vnet"
  vnets      = var.vnet_name
  range      = var.vnet_range
  depends_on = [module.rg]
}

module "snet" {
  source         = "../../modules/snet"
  for_each       = var.vms
  snets          = each.value.snet_name
  address_prefix = each.value.snet_prefix
  depends_on     = [module.vnet]
}

module "pip" {
  source     = "../../modules/pip"
  for_each   = var.vms
  pips       = each.value.pip_name
  depends_on = [module.rg]
}

module "nsg" {
  source     = "../../modules/nsg"
  for_each   = var.vms
  nsgs       = each.value.nsg_name
  depends_on = [module.rg]
}

module "nic" {
  source   = "../../modules/nic"
  for_each = var.vms
  nics     = each.value.nic_name

  # Pass IDs directly from the other modules
  subnet_id = module.snet[each.key].subnet_id
  pip_id    = module.pip[each.key].pip_id
  nsg_id    = module.nsg[each.key].nsg_id
}

module "vm" {
  source   = "../../modules/vm"
  for_each = var.vms
  vms      = each.value.vm_name

  nic_id = module.nic[each.key].nic_id
}
