module "rg" {
  source     = "../../modules/rg"
  env        = var.env
  location   = var.location
  common_tags = local.common_tags
  }