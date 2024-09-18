output "db_instance_endpoint" {
  description = "Endpoint do banco de dados."
  value       = aws_db_instance.db.db_name
}
