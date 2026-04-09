data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_template" "terramino" {
  name_prefix   = "cloud-project-template-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  
  user_data = filebase64("user-data.sh")

  iam_instance_profile {
    name = var.iam_profile
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.instance_sg_id]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "terramino" {
  name                 = "terramino-final-project"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  vpc_zone_identifier  = var.vpc_subnets
  health_check_type    = "ELB"
  
  launch_template {
    id      = aws_launch_template.terramino.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Cloud-Project-Web-Server"
    propagate_at_launch = true
  }
}

# Connects the ASG to your Load Balancer
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.terramino.id
  lb_target_group_arn    = var.target_group_arn
}