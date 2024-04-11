variable "location" {
  description = "Location to deploy resources"
  type = string
}

variable "Business_division" {
  description = "Business division this infrastructure belongs to"
  type = string
}

variable "environment" {
  description = "Environment variable that serves as prefix"
  type = string
}

variable "virtual_network" {
  description = "Virtual network"
  type        = map(string)
}

variable "subnet" {
  description = "virtual network subnets for the 4 tiers"
  type = map(string)
}

variable "network_security_group" {
  description = "Security group for the 4 tiers"
  type = map(string)
}

# Mapping subnet name and NSG name for association
variable "subnet_security_groups" {
  description = "Mapping subnet name and security group name for association"
  type = map(string)
}


