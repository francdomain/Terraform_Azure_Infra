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

  pub_ip_name = ["web-pubip", "jumphost-pubip"]

pub_ip = {
  allocation_method = "Static"
  sku               = "Standard"
}

vm_details = {
  "ip-config-name"    = "internal"
  "private-ip-alloc"  = "Dynamic"
  "admin-username"    = "azureuser"
  "username"          = "azureuser"
  "caching"           = "ReadWrite"
  "storage-acct-type" = "Standard_LRS"
  "publisher"         = "RedHat"
  "offer"             = "RHEL"
  "sku"               = "83-gen2"
  "version"           = "latest"
}


nics = {
  webnic = {
    name   = "web-nic"
    subnet = "websubnet"
    pub_ip = "web-pubip"
  }
  appnic = {
    name   = "app-nic"
    subnet = "appsubnet"
  }
  dbnic = {
    name   = "db-nic"
    subnet = "dbsubnet"
  }
  jumphostnic = {
    name   = "jumphost-nic"
    subnet = "jumphostsubnet"
    pub_ip = "jumphost-pubip"
  }
}

vms = {
  webvm = {
    name            = "web-linuxvm"
    size            = "Standard_DS1_v2"
    nic             = "webnic"
  }
  appvm = {
    name            = "app-linuxvm"
    size            = "Standard_DS1_v2"
    nic             = "appnic"
  }
  dbvm = {
    name            = "db-linuxvm"
    size            = "Standard_DS1_v2"
    nic             = "dbnic"
  }
  jumphostvm = {
    name            = "jumphost-linuxvm"
    size            = "Standard_DS1_v2"
    nic             = "jumphostnic"
  }
}


