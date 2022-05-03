resource "azurerm_storage_account" "picture" {
  name                = "${var.prefix}"
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  access_tier               = "Hot"
  allow_blob_public_access  = true
}

resource "azurerm_storage_container" "picture" {
  name                  = "b01"
  storage_account_name  = azurerm_storage_account.picture.name
  container_access_type = "blob"
}
