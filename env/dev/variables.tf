variable "location" {
  description = "Azure location for the Resource Group"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "vnet_address_space" {
  description = "Virtual Network address space"
  type        = list(string)
}