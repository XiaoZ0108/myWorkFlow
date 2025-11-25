terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.1.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "0323f70b-ddd1-4035-946d-454ac4c95e54"
}