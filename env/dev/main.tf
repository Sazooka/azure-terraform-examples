module "rg" {
  source              = "../../modules/rg"
  env                 = var.env
  location            = var.location
  common_tags         = local.common_tags
  }

  module "vnet" {
  source              = "../../modules/vnet"
  env                 = var.env
  location            = var.location
  common_tags         = local.common_tags
  resource_group_name = module.rg.resource_group_name
  vnet_address_space  = var.vnet_address_space
  }

  module "snet" {
  source              = "../../modules/snet"
  env                 = var.env
  common_tags         = local.common_tags
  resource_group_name = module.rg.resource_group_name
  vnet_name           = module.vnet.vnet_name
  subnet_definitions  = var.subnet_definitions
  }