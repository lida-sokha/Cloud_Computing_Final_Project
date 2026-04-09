output "instance_sg_id" {
  value = aws_security_group.terramino_instance.id
}

output "lb_sg_id" {
  value = aws_security_group.terramino_lb.id
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}