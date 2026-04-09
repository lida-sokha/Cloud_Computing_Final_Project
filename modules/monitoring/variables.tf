variable "asg_name" {
  description = "The name of the ASG to monitor"
  type        = string
}

variable "log_group_name" {
  description = "Name for the CloudWatch log group"
  type        = string
  default     = "/aws/ec2/Cloud-Project-Web-Server"
}