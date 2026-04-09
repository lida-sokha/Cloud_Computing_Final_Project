output "scaling_policy_arn" {
  description = "The ARN of the CPU scaling policy"
  value       = aws_autoscaling_policy.cpu_scaling.arn
}

output "scaling_policy_name" {
  value = aws_autoscaling_policy.cpu_scaling.name
}