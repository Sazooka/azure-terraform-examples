variable "env" {
  description = "Environment name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource_group_name"
  type        = string
}

variable "location" {
  description = "Azure location for the Resource Group"
  type        = string
}

variable "common_tags" {
  description = "common_tags"
  type    = map(string)
  default = {}
}
