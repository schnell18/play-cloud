resource "random_pet" "mysql" {
}

resource "random_password" "password" {
  length           = 16
  special          = true
  lower            = true
  upper            = true
  number           = true
  min_lower        = 4
  min_numeric      = 2
  min_special      = 2
  min_upper        = 4
  override_special = "^_%@"
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = "${var.subnet_ids}"

  tags = {
    Name = "MySQL subnet group"
  }
}

resource "aws_db_instance" "default" {
  identifier             = random_pet.mysql.id
  db_name                = "${var.database_name}"
  username               = "${var.admin_user}"
  allocated_storage      = "${var.storage_gb}"
  multi_az               = "${var.multi_az}"
  engine                 = "mysql"
  engine_version         = "${var.mysql_engine["version"]}"
  parameter_group_name   = "${var.mysql_engine["parameter_group"]}"
  instance_class         = "db.t3.micro"
  password               = random_password.password.result
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [ "${var.security_group_id}" ]
}

