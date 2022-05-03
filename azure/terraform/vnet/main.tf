# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = "eastus"
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "jump_server" {
  name                 = "jump_server"
  address_prefixes     = ["10.1.1.0/24"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}
resource "azurerm_subnet" "mysql" {
  name                 = "mysql"
  address_prefixes     = ["10.1.2.0/24"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  # Microsoft.DBforMySQL/servers
  service_endpoints    = ["Microsoft.Sql"]
}

resource "azurerm_subnet" "rocketmq" {
  name                 = "rocketmq"
  address_prefixes     = ["10.1.3.0/24"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "k8s" {
  name                 = "k8s"
  address_prefixes     = ["10.1.128.0/17"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

# resource "azurerm_subnet" "redis" {
#   name                 = "redis"
#   address_prefixes     = ["10.1.4.0/24"]
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = azurerm_virtual_network.vnet.name
# }
