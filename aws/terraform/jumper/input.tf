variable "subnet_id" {
  description = "subnet id" 
}

variable "security_group_id" {
  description = "security group id" 
}

variable "qty" {
  description = "number of instances to launch" 
  default = "1"
}

variable "instance" {
  description = ""
  default = {
    "type" = "t3.micro"
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

variable "ami" {
  description = ""
  # For ami-id to use, refer to: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html#finding-quick-start-ami
  default = "ami-0ac97798ccf296e02"
}

variable "key" {
  description = "OPS public key"
  default = {
    "name" = "opsbot"
    "pub"  = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIFpaQ95wDzJoNeHaiwAXzS3M4GP6efFwYkBLZwH646R Cloud OPS"
  }
}
