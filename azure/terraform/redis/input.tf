variable "prefix" {}
variable "location" {}
variable "resource_group_name" {}

variable "redis_name" {
  description = "Redis service name as known to application, must be globally unique."
  default = "exploremyredis"
}
