output "address" {
  value = aws_db_instance.this.address
}

output "port" {
  value = aws_db_instance.this.port
}

output "username" {
  value = aws_db_instance.this.username
}

output "password_secret_key" {
  value = try(aws_secretsmanager_secret.rds_password[0].name, null)
}

output "db_name" {
  value = aws_db_instance.this.db_name
}

output "db_arn" {
  value = aws_db_instance.this.arn
}

output "client_security_group" {
  value = aws_security_group.client.id
}

output "db_resource_id" {
  value = aws_db_instance.this.resource_id
}
