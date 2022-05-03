variable "prefix" {}
variable "location" {}
variable "resource_group_name" {}
variable "jump_server_subnet_id" {}

# SKU spec: https://docs.microsoft.com/en-us/azure/virtual-machines/dav4-dasv4-series
variable "jump_server_sku" {
  description = "Linux VM SKU"
  default = "Standard_D4s_v3"
}

variable "data_disk_size_gb" {
  description = "Data disk size in Giga byte"
  default = "50"
}

variable "storage_type" {
  description = "Storage Type of OS and data disks"
  default = "Standard_LRS"
}

