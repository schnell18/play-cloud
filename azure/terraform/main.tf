# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

module "base" {
  source              = "./base"
  prefix              = var.resource_name_prefix
  location            = "eastus"
}

module "vnet" {
  source               = "./vnet"
  prefix               = var.resource_name_prefix
  resource_group_name  = module.base.resource_group_name
}

module "pictures" {
  source                  = "./pictures"
  location                = var.location
  prefix                  = var.resource_name_prefix
  resource_group_name     = module.base.resource_group_name
}

module "mysql" {
  source                           = "./mysql"
  prefix                           = var.resource_name_prefix
  resource_group_name              = module.base.resource_group_name
  mysql_server_databases_to_create = toset(["inventory", "purchase"])
  location                         = var.location
  mysql_subnet_id                  = module.vnet.mysql_subnet_id
}

module "jumpserver" {
  source                = "./jumpserver"
  location              = var.location
  prefix                = var.resource_name_prefix
  resource_group_name   = module.base.resource_group_name
  jump_server_subnet_id = module.vnet.jump_server_subnet_id
}

module "kubernetes" {
  source              = "./kubernetes"
  prefix              = var.resource_name_prefix
  location            = var.location
  resource_group_name = module.base.resource_group_name
  k8s_subnet_id       = module.vnet.k8s_subnet_id
}

module "rocketmq" {
  source              = "./rocketmq"
  prefix              = var.resource_name_prefix
  location            = var.location
  resource_group_name = module.base.resource_group_name
  rocketmq_subnet_id  = module.vnet.rocketmq_subnet_id
  admin_ssh_pub_key   = module.jumpserver.admin_ssh_pub_key
}

# module "redis" {
#   source              = "./redis"
#   location            = var.location
#   prefix              = var.resource_name_prefix
#   resource_group_name = module.base.resource_group_name
# }

