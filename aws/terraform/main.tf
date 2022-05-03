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
  profile  = "default"
  region = "ap-northeast-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.20.0.0/16"

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_security_group" "poincare" {
  name = "poincare"
  description = "Security configs for poincare App"
  vpc_id   = aws_vpc.main.id
  ingress {
    cidr_blocks  = ["0.0.0.0/0"]
    from_port    = 22
    to_port      = 22
    protocol     = "tcp"
    description  = "Open SSH port to all"
  }

  ingress {
    cidr_blocks  = ["0.0.0.0/0"]
    from_port    = 443
    to_port      = 443
    protocol     = "tcp"
    description  = "Open HTTP port to all"
  }

  egress {
    from_port    = 0
    to_port      = 0
    protocol     = "-1"
    cidr_blocks  = ["0.0.0.0/0"] 
    description  = "allow all outgoing connections"
  }

}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.20.1.0/24"

  tags = {
    Name = "Main"
  }
}

resource "aws_route_table" "internet" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.internet.id
}

resource "aws_network_interface" "eth0" {
  subnet_id   = aws_subnet.main.id
  private_ips = ["10.20.1.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "poincare" {
  count = "${var.qty}"

  ami                         = "${var.ami}"
  instance_type               = "${var.instance["type"]}"
  key_name                    = "${var.key["name"]}"
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = ["${aws_security_group.poincare.id}"]
  disable_api_termination     = false
  associate_public_ip_address = true
  user_data                   = templatefile("./cloud-init.tpl", {})

  root_block_device {
    # 30G is max-volume for free-tier
    volume_size = 30
    volume_type = "gp3"
  }

  network_interface {
    network_interface_id = aws_network_interface.eth0.id
    device_index         = 0
  }

  lifecycle {
    prevent_destroy = false
  }

  timeouts {
    create = "7m"
    delete = "1h"
  }

  tags = {
    Name       = "${var.tags["name"]}"
    App        = "${var.tags["app"]}"
    Maintainer = "${var.tags["maintainer"]}"
    Role       = "${var.tags["role"]}"
  }

  depends_on = [ aws_key_pair.poincare, aws_internet_gateway.internet]

}

resource "aws_key_pair" "poincare" {
  key_name = "${var.key["name"]}"
  public_key = "${var.key["pub"]}"
}
