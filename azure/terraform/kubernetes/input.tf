variable "k8s_subnet_id" {}
variable "prefix" {}
variable "location" {}
variable "resource_group_name" {}

variable "image_registry_sku" {
  description = "Azure image registry sku"
  default = "standard"
}

variable "k8s_node_count" {
  description = "Nubmer kubernetes worker node"
  default = "2"
}

# SKU spec: https://docs.microsoft.com/en-us/azure/virtual-machines/dav4-dasv4-series
variable "k8s_node_sku" {
  description = "Linux VM SKU"
  default = "Standard_D4s_v3"
}

