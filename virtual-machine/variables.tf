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

# Virtual Network
variable "virtual_network" {
  description = "Virtual network"
  type        = map(string)
}

# Subnets
variable "subnet" {
  description = "virtual network subnets for the 4 tiers"
  type = map(string)
}

# NSGs
variable "network_security_group" {
  description = "Security group for the 4 tiers"
  type = map(string)
}

# Mapping subnet name and NSG name for association
variable "subnet_security_groups" {
  description = "Mapping subnet name and security group name for association"
  type = map(string)
}

# Public IP
variable "pub_ip_name" {
  description = "Names of web and jump host public ip address"
  type = list(string)
}
variable "pub_ip" {
  description = "Public ip for the web server"
  type        = map(string)
}

# variable "network_interface" {
#   description = "Network interface card for the virtual machines"
#   type = list(string)
# }

variable "nics" {
  description = ""
  type = map
}

# variable "virtual_machine" {
#   description = "Virtual machine for the 4 tiers"
#   type = list(string)
# }

variable "vms" {
  description = ""
  type = map
}

variable "vm_details" {
  description = ""
  type = map(string)
}


