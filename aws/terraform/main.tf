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

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "default" {
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "Default subnet"
  }
}

resource "aws_security_group" "poincare" {
  vpc_id = aws_default_vpc.default.id

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

resource "aws_instance" "poincare" {
  count = "${var.qty}"

  ami                         = "${var.ami}"
  instance_type               = "${var.instance["type"]}"
  key_name                    = "${var.key["name"]}"
  subnet_id                   = aws_default_subnet.default.id
  vpc_security_group_ids      = ["${aws_security_group.poincare.id}"]
  disable_api_termination     = false
  associate_public_ip_address = true
  user_data                   = templatefile("./cloud-init.tpl", {})

  tags = {
    Name       = "${var.tags["name"]}"
    App        = "${var.tags["app"]}"
    Maintainer = "${var.tags["maintainer"]}"
    Role       = "${var.tags["role"]}"
  }

  root_block_device {
    # 30G is max-volume for free-tier
    volume_size = 30
    volume_type = "gp3"
  }

  depends_on = [ aws_key_pair.poincare ]

  lifecycle {
    prevent_destroy = false
  }

  timeouts {
    create = "7m"
    delete = "1h"
  }

}


resource "aws_key_pair" "poincare" {
  key_name = "${var.key["name"]}"
  public_key = "${var.key["pub"]}"
}
