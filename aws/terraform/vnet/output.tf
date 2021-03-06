output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "mysql_subnet_id_1a" {
  value = aws_subnet.mysql1a.id
}

output "mysql_subnet_id_1c" {
  value = aws_subnet.mysql1c.id
}

output "main_security_group_id" {
  value = aws_security_group.main.id
}

output "mysql_security_group_id" {
  value = aws_security_group.mysql.id
}

