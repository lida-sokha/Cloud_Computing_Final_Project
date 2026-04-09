output "log_group_name" {
  description = "The name of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.web_logs.name
}

output "cpu_alarm_id" {
  description = "The ID of the CloudWatch CPU alarm"
  value       = aws_cloudwatch_metric_alarm.cpu_alarm.id
}