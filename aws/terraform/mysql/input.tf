variable "subnet_ids" {
  description = "subnet id" 
}

variable "security_group_id" {
  description = "security group id" 
}

variable "database_name" {
  description = "Name of database to create"
}

variable "admin_user" {
  description = "Admin user of MySQL database"
  default = "root"
}

variable "storage_gb" {
  description = "Allocated storage size in GB"
  default = "20"
}

variable "multi_az" {
  description = "Enable multi available zone"
  default = "false"
}

variable "mysql_engine" {
  description = "MySQL engine settings"
  default = {
    version         = "8.0.28"
    parameter_group = "default.mysql8.0"
  }
}
