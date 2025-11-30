variable "env" {
  description = "Environment name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource_group_name"
  type        = string
}

variable "common_tags" {
  description = "common_tags"
  type    = map(string)
  default = {}
}

variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
}

variable "subnet_definitions"{
  type        = map(object({
    address_prefixes = string 
    delegation_name     = optional(string)
    delegation_service  = optional(string)
    delegation_actions  = optional(list(string))
    #nsg_key nsg_key    = optional(string) # NSG key

  }))
  default = {}
  description = "subnet cidr"
}

