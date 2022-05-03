variable "qty" {
  description = "number of instances to launch" 
  default = "1"
}

variable "instance" {
  description = ""
  default = {
    "type" = "t2.micro"
  }
}

variable "tags" {
  description = ""
  default = {
    "name" = "poincare-demo"
    "app"  = "poincare-demo"
    "maintainer" = "TinkerIT"
    "role" = "backend"
  }
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  default = "10.30.0.0/16"
}

variable "subnet_cidr_block" {
  description = "subnet CIDR block"
  default     = "10.30.1.0/24"
}

# variable "subnet_cidr_blocks" {
#   description = "subnet CIDR blocks"
#   default     = {
#     "backend" = "10.30.1.0/24"
#     "mysql"   = "10.30.2.0/24"
#   }
# }
