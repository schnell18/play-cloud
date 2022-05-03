variable "prefix" {}
variable "location" {}
variable "resource_group_name" {}
variable "rocketmq_subnet_id" {}
variable "admin_ssh_pub_key" {}

variable "rocketmq_initial_instances" {
  description = "Initial Linux VM scaleset instances"
  default = "1"
}

variable "rocketmq_max_instances" {
  description = "Max Linux VM scaleset instances"
  default = "5"
}

variable "rocketmq_min_instances" {
  description = "Min Linux VM scaleset instances"
  default = "1"
}

# SKU spec: https://docs.microsoft.com/en-us/azure/virtual-machines/dav4-dasv4-series
variable "rocketmq_sku" {
  description = "Linux VM scaleset SKU"
  default = "Standard_D4s_v4"
}

variable "data_disk_size_gb" {
  description = "Data disk size in Giga byte"
  default = "50"
}

variable "storage_type" {
  description = "Storage Type of OS and data disks"
  default = "Standard_LRS"
}
