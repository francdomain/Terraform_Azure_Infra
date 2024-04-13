locals {
  owner = var.Business_division
  environment = var.environment
  resource_name_prefix = "${var.Business_division}-${var.environment}-${var.location}"
  common_tags = {
    owner = local.owner
    environment = local.environment
  }
}


locals {
  web_nsg_rules = {
    http = {
      name                       = "AllowAnyHTTPInboundtoWeb"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = 80
      source_address_prefix      = "*"
      destination_address_prefix = "10.0.1.0/24"
    }
    https = {
      name                       = "AllowAnyHTTPSInboundtoWeb"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = 443
      source_address_prefix      = "*"
      destination_address_prefix = "10.0.1.0/24"
    }
    ssh = {
      name                       = "AllowAnySSHInboundtoWeb"
      priority                   = 140
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = 22
      source_address_prefix      = "*"
      destination_address_prefix = "10.0.1.0/24"
    }
  }

  app_nsg_rules = {
    http = {
      name                       = "AllowWebHTTPInboundtoApp"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = 80
      destination_port_range     = 80
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "10.0.11.0/24"
    }
    ssh = {
      name                       = "AllowWebSSHInboundtoApp"
      priority                   = 140
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = 22
      source_address_prefix      = "*"
      destination_address_prefix = "10.0.11.0/24"
    }
    https = {
      name                       = "AllowWebHTTPSInboundtoApp"
      priority                   = 160
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = 443
      destination_port_range     = 443
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "10.0.11.0/24"
    }
  }

  db_nsg_rules = {
    rule1 = {
      name                       = "DenyAnyInboundtoDB"
      priority                   = 140
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = 3306
      source_address_prefix      = "*"
      destination_address_prefix = "10.0.21.0/24"
    }
    rule2 = {
      name                       = "AllowAppInboundtoDB"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = 3306
      source_address_prefix      = "10.0.11.0/24"
      destination_address_prefix = "10.0.21.0/24"
    }
    ssh = {
      name                       = "AllowAppSSHInboundtoDB"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = 22
      source_address_prefix      = "*"
      destination_address_prefix = "10.0.21.0/24"
    }
    rule3 = {
      name                       = "AllowDBOutboundtoApp"
      priority                   = 160
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = 3306
      destination_port_range     = "*"
      source_address_prefix      = "10.0.21.0/24"
      destination_address_prefix = "10.0.11.0/24"
    }
    rule4 = {
      name                       = "DenyDBOutboundtoWeb"
      priority                   = 180
      direction                  = "Outbound"
      access                     = "Deny"
      protocol                   = "Tcp"
      source_port_range          = 3306
      destination_port_range     = "*"
      source_address_prefix      = "10.0.21.0/24"
      destination_address_prefix = "*"
    }
  }

  jumphost_nsg_rules = {
    ssh = {
      name                       = "AllowJumpHostSSHInbound"
      priority                   = 140
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = 22
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}


