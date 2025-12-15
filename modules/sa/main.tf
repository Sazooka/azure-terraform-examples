########################################
# Storage Account
########################################
resource "azurerm_storage_account" "main" {
  name                      = "${var.env}SA${random_string.suffix.result}" 
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  https_traffic_only_enabled = true    # Force HTTPS only for secure data transfer. HTTP requests will be blocked.
  min_tls_version           = "TLS1_2" # Azure Storage will stop accepting TLS 1.0/1.1 after Nov 1, 2025.
                                       # Early 2026: TLS 1.0/1.1 fully retired.
  public_network_access_enabled = false
  allow_nested_items_to_be_public = false

 }
 
########################################
# Random suffix for unique SA name
########################################
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}




########################################
# Outputs
########################################
output "storage_account_id" {
  description = "Storage Account ID"
  value       = azurerm_storage_account.main.id
}


