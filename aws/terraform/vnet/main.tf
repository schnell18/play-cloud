resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr_block}"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "${var.subnet_cidr_block}"

  tags = {
    Name = "Main subnet"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "${var.subnet_cidr_block_public}"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public subnet"
  }
}

resource "aws_subnet" "mysql1c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "${var.subnet_cidr_block_mysql1c}"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "MySQL subnet az 1c"
  }
}

resource "aws_subnet" "mysql1a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "${var.subnet_cidr_block_mysql1a}"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "MySQL subnet az 1a"
  }
}

resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_security_group" "main" {
  name = "main"
  description = "Security configs for main App"
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

resource "aws_security_group" "mysql" {
  name = "mysql"
  description = "Security configs for mysql"
  vpc_id   = aws_vpc.main.id

  ingress {
    cidr_blocks  = ["10.30.0.0/16"]
    from_port    = 3306
    to_port      = 3306
    protocol     = "tcp"
    description  = "Open MySQL port to VPC"
  }

  egress {
    from_port    = 0
    to_port      = 0
    protocol     = "-1"
    cidr_blocks  = ["0.0.0.0/0"] 
    description  = "allow all outgoing connections"
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
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.internet.id
}

# resource "aws_network_interface" "eth0" {
#   subnet_id   = aws_subnet.main.id
#   private_ips = ["10.20.1.100"]
#   tags = {
#     Name = "primary_network_interface"
#   }
# }
