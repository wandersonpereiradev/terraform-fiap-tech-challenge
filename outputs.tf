output "db_instance_endpoint" {
  description = "O endpoint para conectar ao banco de dados."
  value       = aws_db_instance.db_instance.endpoint
}

output "db_instance_arn" {
  description = "ARN da instância RDS criada."
  value       = aws_db_instance.db_instance.arn
}