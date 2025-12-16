terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" # or latest stable version
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "9cc43bbd-37ec-4db9-b309-bf9f2060e02f"
}