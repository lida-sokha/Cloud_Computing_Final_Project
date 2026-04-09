output "db_endpoint" {
  description = "The connection endpoint for the database"
  value       = data.aws_db_instance.todo_db.address
}

output "db_port" {
  value = data.aws_db_instance.todo_db.port
}