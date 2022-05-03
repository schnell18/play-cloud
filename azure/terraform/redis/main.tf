# NOTE: the Name used for Redis needs to be globally unique
resource "azurerm_redis_cache" "worker" {
  name                = "${var.prefix}-redis"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 1
  family              = "C"
  sku_name            = "Basic"
  enable_non_ssl_port = false
}
