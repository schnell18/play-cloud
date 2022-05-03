resource "random_password" "password" {
  length           = 16
  special          = true
  lower            = true
  upper            = true
  number           = true
  min_lower        = 4
  min_numeric      = 2
  min_special      = 2
  min_upper        = 4
  override_special = "^_%@"
}

resource "azurerm_mysql_server" "mysql" {
  name                = "${var.prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.mysql_admin_name
  administrator_login_password = random_password.password.result

  sku_name   = var.mysql_server_sku
  storage_mb = var.mysql_server_storage
  version    = var.mysql_server_version

  auto_grow_enabled                 = false
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = false
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"

}

# resource "azurerm_mysql_virtual_network_rule" "mysql" {
#   name                = "mysql-vnet-rule"
#   resource_group_name = var.resource_group_name
#   server_name         = azurerm_mysql_server.mysql.name
#   subnet_id           = var.mysql_subnet_id
# }

resource "azurerm_mysql_database" "db" {
  for_each = var.mysql_server_databases_to_create
  name                = each.key
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.mysql.name
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
}

