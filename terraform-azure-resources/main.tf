terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.4"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  required_version = ">= 1.1.0" # Set this to require a minimum Terraform version
}

provider "azurerm" {
  features {}
}

resource "random_string" "example" {
  length    = 4
  min_lower = 4
  special   = false
}

resource "azurerm_resource_group" "example" {
  name     = "myTFResourceGroup-${random_string.example.result}"
  location = "westeurope"
}

resource "azurerm_storage_account" "example" {
  name                     = "exstorageacct${random_string.example.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
