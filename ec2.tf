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
  
  # Note: Use the templated version we discussed to get the DB endpoint!
  user_data = base64encode(templatefile("user-data.sh", {
    db_address = module.database.db_endpoint
  }))

  iam_instance_profile {
    # UPDATED: Points to security module output
    name = module.security.instance_profile_name
  }

  network_interfaces {
    associate_public_ip_address = true
    # UPDATED: Points to security module output
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
  # UPDATED: Changed 'module.vpc' to 'module.network'
  vpc_zone_identifier  = module.network.public_subnets

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