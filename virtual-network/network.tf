resource "azurerm_virtual_network" "vnet" {
  name                = "${local.resource_name_prefix}-${var.virtual_network.vnet_name}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = [var.virtual_network.vnet_address]
  tags                = local.common_tags
}

# Creating the 4 subnets
resource "azurerm_subnet" "subnet" {
  for_each             = var.subnet
  name                 = each.key
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value]
}

# Creating the 4 NSGs
resource "azurerm_network_security_group" "nsg" {
  for_each            = var.network_security_group
  name                = each.value
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}

resource "azurerm_subnet_network_security_group_association" "subnet-nsga" {
  for_each                  = var.subnet_security_groups
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.value].id

  depends_on = [
    azurerm_network_security_rule.webnsg-rule,
    azurerm_network_security_rule.appnsg-rule,
    azurerm_network_security_rule.dbnsg-rule
  ]
}

# NSG Rules
resource "azurerm_network_security_rule" "webnsg-rule" {
  for_each                    = local.web_nsg_rules
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = var.network_security_group.web_sg
  depends_on = [
    azurerm_network_security_group.nsg
  ]
}

resource "azurerm_network_security_rule" "appnsg-rule" {
  for_each                    = local.app_nsg_rules
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = var.network_security_group.app_sg
  depends_on = [
    azurerm_network_security_group.nsg
  ]
}

resource "azurerm_network_security_rule" "dbnsg-rule" {
  for_each                    = local.db_nsg_rules
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = var.network_security_group.db_sg
  depends_on = [
    azurerm_network_security_group.nsg
  ]
}

resource "azurerm_network_security_rule" "jumphostnsg-rule" {
  for_each                    = local.jumphost_nsg_rules
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = var.network_security_group.jumphost_sg
  depends_on = [
    azurerm_network_security_group.nsg
  ]
}

