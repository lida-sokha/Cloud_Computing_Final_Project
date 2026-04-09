    provider "aws" {
      region = "us-east-1"

      default_tags {
        tags = {
          hashicorp-learn = "aws-asg"
        }
      }
    }

    data "aws_availability_zones" "available" {
      state = "available"
    }


    resource "aws_lb" "terramino" {
      name               = "learn-asg-terramino-lb"
      internal           = false
      load_balancer_type = "application"
      security_groups    = [aws_security_group.terramino_lb.id]
      subnets            = module.vpc.public_subnets
    }

    resource "aws_lb_listener" "terramino" {
      load_balancer_arn = aws_lb.terramino.arn
      port               = "80"
      protocol           = "HTTP"

      default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.terramino.arn
      }
    }

    resource "aws_lb_target_group" "terramino" {
      name     = "learn-asg-terramino"
      port     = 80
      protocol = "HTTP"
      vpc_id   = module.vpc.vpc_id
    }

    resource "aws_security_group" "terramino_instance" {
      name   = "learn-asg-terramino-instance"
      vpc_id = module.vpc.vpc_id

      ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        security_groups = [aws_security_group.terramino_lb.id]
      }

      egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }

    resource "aws_security_group" "terramino_lb" {
      name   = "learn-asg-terramino-lb"
      vpc_id = module.vpc.vpc_id

      ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

      egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
    module "monitoring" {
      source   = "./modules/monitoring"
      asg_name = aws_autoscaling_group.terramino.name
    }

    module "scaling" {
      source   = "./modules/scaling"
      asg_name = aws_autoscaling_group.terramino.name
    }

    module "vpc" {
      source     = "./modules/vpc"
      vpc_name   = "my-final-project-vpc"
      cidr_block = "10.0.0.0/16"
    }