terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.12.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}

module "vnet" {
  source         = "./vnet"
  vpc_cidr_block = "10.30.0.0/16"
}

module "jumper" {
  source            = "./jumper"
  tags              = var.tags
  instance          = var.instance
  qty               = var.qty
  subnet_id         = module.vnet.public_subnet_id
  security_group_id = module.vnet.main_security_group_id
}

module "mysql" {
  source            = "./mysql"
  admin_user        = "root"
  database_name     = "poincare"
  security_group_id = module.vnet.mysql_security_group_id
  subnet_ids        = [module.vnet.mysql_subnet_id_1a, module.vnet.mysql_subnet_id_1c]
}
