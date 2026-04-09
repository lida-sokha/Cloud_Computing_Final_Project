variable "vpc_subnets" {
  description = "Public subnets from the network module"
  type        = list(string)
}

variable "instance_sg_id" {
  description = "Security group ID from the security module"
  type        = string
}

variable "iam_profile" {
  description = "IAM Instance Profile name from the security module"
  type        = string
}

variable "target_group_arn" {
  description = "The ARN of the Load Balancer target group"
  type        = string
}

variable "db_endpoint" {
  description = "The endpoint address of the RDS database"
  type        = string
}