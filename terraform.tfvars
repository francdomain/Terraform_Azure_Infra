Business_division       = "hr"
location                = "eastus2"
environment             = "dev"

virtual_network = {
    "vnet_name"    = "vnet"
    "vnet_address" = "10.0.0.0/16"
  }

subnet = {
    "websubnet"      = "10.0.1.0/24"
    "appsubnet"      = "10.0.11.0/24"
    "dbsubnet"       = "10.0.21.0/24"
    "jumphostsubnet" = "10.0.100.0/24"
  }

network_security_group = {
    "web_sg"      = "webnsg"
    "app_sg"      = "appnsg"
    "db_sg"       = "dbnsg"
    "jumphost_sg" = "jumphostnsg"
  }

subnet_security_groups = {
    "websubnet"      = "web_sg"
    "appsubnet"      = "app_sg"
    "dbsubnet"       = "db_sg"
    "jumphostsubnet" = "jumphost_sg"
  }

