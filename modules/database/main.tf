# This looks up the database you created manually named "todo"
data "aws_db_instance" "todo_db" {
  db_instance_identifier = "todo"
}