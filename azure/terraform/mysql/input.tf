variable "prefix" {}
variable "location" {}
variable "resource_group_name" {}
variable "mysql_subnet_id" {}

variable "mysql_admin_name" {
  default = "myadmin"
}
variable "mysql_server_databases_to_create" {
  default = ["inventory", "purchase"]
}
variable "mysql_server_version" {
  default = "5.7"
}
variable "mysql_server_sku" {
  default = "GP_Gen5_2"
}
variable "mysql_server_storage" {
  default = 51200
}
