variable "location" {
  description = "Azure location for the Resource Group"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "common_tags" {
  description = "common_tags"
  type    = map(string)
  default = {}
}