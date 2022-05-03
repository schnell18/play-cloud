output "mysql_admin_password" {
  value = azurerm_mysql_server.mysql.administrator_login_password 
}

output "mysql_server_fqdn" {
  value = azurerm_mysql_server.mysql.fqdn 
}
