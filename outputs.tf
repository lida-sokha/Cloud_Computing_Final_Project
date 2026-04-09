# This prints the URL you need to visit to see your website!
output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.terramino.dns_name
}

# This shows that your scaling module is active
output "asg_scaling_policy" {
  value = module.scaling.scaling_policy_name
}

# This shows where to find your logs
output "cloudwatch_logs" {
  value = module.monitoring.log_group_name
}