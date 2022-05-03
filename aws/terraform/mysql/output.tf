output "db_password" {
  value = aws_db_instance.default.password
}

output "db_admin" {
  value = aws_db_instance.default.username
}

