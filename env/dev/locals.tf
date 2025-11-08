locals {
  # Common Tags
  common_tags = {
    Project   = "TerraformDemo"
    ManagedBy = "Terraform"
  }

  # Environment Tags
  env_tags = {
    Environment = "dev"
  }

  # merge
  merged_tags = merge(local.common_tags, local.env_tags)
}
