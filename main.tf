provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project = "Cloud-Computing-Final"
    }
  }
}

# 1. NETWORK MODULE (VPC, Subnets)
module "network" {
  source         = "./modules/networking"
  vpc_name       = "final-project-network"
  vpc_cidr       = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

# 2. DATABASE MODULE (Looking up your manual "todo" DB)
module "database" {
  source = "./modules/database"
}

# 3. SECURITY MODULE (IAM and Security Group logic)
module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
}

# 4. STORAGE MODULE (S3 Bucket)
module "storage" {
  source      = "./modules/storage"
  bucket_name = "my-unique-web-assets-12345"
}

# 5. COMPUTE MODULE (ASG and Launch Template)
module "compute" {
  source           = "./modules/compute"
  vpc_subnets      = module.network.public_subnets
  instance_sg_id   = module.security.instance_sg_id
  iam_profile      = module.security.instance_profile_name
  target_group_arn = aws_lb_target_group.terramino.arn
  db_endpoint      = module.database.db_endpoint # Passing the DB info here
}

# 6. LOAD BALANCER (The front door)
resource "aws_lb" "terramino" {
  name               = "terramino-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.security.lb_sg_id]
  subnets            = module.network.public_subnets
}

resource "aws_lb_listener" "terramino" {
  load_balancer_arn = aws_lb.terramino.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terramino.arn
  }
}

resource "aws_lb_target_group" "terramino" {
  name     = "terramino-tg-v2"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = module.network.vpc_id

  health_check {
    path = "/"
    port = "3000"
  }
}

# 7. MONITORING & SCALING (Connected to the Compute ASG)
module "monitoring" {
  source   = "./modules/monitoring"
  asg_name = module.compute.asg_name
}

module "scaling" {
  source   = "./modules/scaling"
  asg_name = module.compute.asg_name
}