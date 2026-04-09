data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_template" "terramino" {
  name_prefix   = "learn-terraform-aws-asg-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  
  user_data = filebase64("user-data.sh")

  iam_instance_profile {
    name = module.security.instance_profile_name
  }

  monitoring {
    enabled = true 
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [module.security.instance_sg_id]
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
  vpc_zone_identifier  = module.vpc.public_subnets

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

resource "aws_autoscaling_attachment" "terramino" {
  autoscaling_group_name = aws_autoscaling_group.terramino.id
  lb_target_group_arn    = aws_lb_target_group.terramino.arn # Changed this line
}

# Create the IAM Role
resource "aws_iam_role" "ec2_role" {
  name = "cloud_project_ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

# Attach the CloudWatch policy
resource "aws_iam_role_policy_attachment" "cw_agent" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Create the profile to be used by the Launch Template
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "cloud_project_ec2_profile"
  role = aws_iam_role.ec2_role.name
}