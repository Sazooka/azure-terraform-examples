module "rg" {
  source           = "../../modules/rg"
  env              = var.env
  location         = var.location
  common_tags      = local.common_tags
  }

  module "vnet" {
  source              = "../../modules/vnet"
  env                 = var.env
  location            = var.location
  common_tags         = local.common_tags
  resource_group_name = module.rg.resource_group_name
  }