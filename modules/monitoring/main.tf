resource "aws_cloudwatch_log_group" "web_logs" {
  name              = var.log_group_name
  retention_in_days = 7
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "High-CPU-Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = var.asg_name # This links the alarm to your ASG!
  }

  alarm_description = "This metric monitors EC2 CPU utilization"
}