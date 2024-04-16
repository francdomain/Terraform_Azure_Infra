terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>3.98.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~>3.6.1"
    }
    null = {
      source = "hashicorp/null"
      version = "~>3.2.2"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

