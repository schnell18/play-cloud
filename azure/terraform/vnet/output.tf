output "mysql_subnet_id" {
  value = azurerm_subnet.mysql.id  
}

output "k8s_subnet_id" {
  value = azurerm_subnet.k8s.id  
}

output "jump_server_subnet_id" {
  value = azurerm_subnet.jump_server.id  
}

output "rocketmq_subnet_id" {
  value = azurerm_subnet.rocketmq.id  
}

# output "redis_subnet_id" {
#   value = azurerm_subnet.redis.id  
# }
