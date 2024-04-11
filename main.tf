# resource "random_integer" "ri" {
#   min = 10000
#   max = 99999
# }

resource "azurerm_resource_group" "main" {
  name     = "${local.resource_name_prefix}-rg"
  location = var.location
  tags = local.common_tags
}


