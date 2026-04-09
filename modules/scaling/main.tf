resource "aws_autoscaling_policy" "cpu_scaling" {
  name                   = "target-cpu-utilization"
  autoscaling_group_name = var.asg_name # Use a variable here!
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 70.0 
  }
}