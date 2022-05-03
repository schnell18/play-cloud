variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  default = "10.30.0.0/16"
}

variable "subnet_cidr_block" {
  description = "subnet CIDR block"
  default     =  "10.30.1.0/24"
}

variable "subnet_cidr_block_public" {
  description = "subnet CIDR block for server expose to internet"
  default     =  "10.30.2.0/24"
}

variable "subnet_cidr_block_mysql1c" {
  description = "subnet CIDR block for MySQL"
  default     =  "10.30.50.0/24"
}

variable "subnet_cidr_block_mysql1a" {
  description = "subnet CIDR block for MySQL"
  default     =  "10.30.49.0/24"
}
