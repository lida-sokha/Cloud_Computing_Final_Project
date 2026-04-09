output "asg_name" {
  value       = aws_autoscaling_group.terramino.name
  description = "The name of the Auto Scaling Group"
}

output "asg_id" {
  value = aws_autoscaling_group.terramino.id
}