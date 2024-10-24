terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.5.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-staticsite-lb-tf-vinicius"
    storage_account_name = "staticsitelbtfvinicius"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}