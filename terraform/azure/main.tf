provider "azurerm" {
  features {}
}

# Criando o grupo de recursos
# resource "azurerm_resource_group" "multicloud" {
#   name     = "multicloud-resources"
#   location = "East US"
# }

# VNet 1
resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  address_space       = ["10.0.0.0/16"]
  location            = var.azurerm_resource_group_location
  resource_group_name = var.azurerm_resource_group_name
}

# Sub-rede para a VNet 1
resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = var.azurerm_resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]
}

# VNet 2
resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet2"
  address_space       = ["10.1.0.0/16"]
  location            = var.azurerm_resource_group_location
  resource_group_name = var.azurerm_resource_group_name
}

# Sub-rede para a VNet 2
resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = var.azurerm_resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["10.1.1.0/24"]
  
  private_endpoint_network_policies = true 
}

# Criando o peering da VNet 1 para a VNet 2
resource "azurerm_virtual_network_peering" "vnet1-to-vnet2" {
  name                      = "vnet1-to-vnet2"
  resource_group_name        = var.azurerm_resource_group_name
  virtual_network_name       = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id  = azurerm_virtual_network.vnet2.id
  allow_forwarded_traffic    = true
  allow_gateway_transit      = false
  use_remote_gateways        = false
}

# Criando o peering da VNet 2 para a VNet 1
resource "azurerm_virtual_network_peering" "vnet2-to-vnet1" {
  name                      = "vnet2-to-vnet1"
  resource_group_name        = var.azurerm_resource_group_name
  virtual_network_name       = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id  = azurerm_virtual_network.vnet1.id
  allow_forwarded_traffic    = true
  allow_gateway_transit      = false
  use_remote_gateways        = false
}
