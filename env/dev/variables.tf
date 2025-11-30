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

variable "subnet_definitions"{
  type        = map(object({
    address_prefixes    = string 
    delegation_name     = optional(string)
    delegation_service  = optional(string)
    delegation_actions  = optional(list(string))
    #nsg_key
  }))
  default = {}
  description = "subnet cidr"
}