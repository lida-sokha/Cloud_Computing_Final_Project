# Find available zones (us-east-1a, us-east-1b, etc.)
data "aws_availability_zones" "available" {
  state = "available"
}

# Use the official AWS VPC module to build the network
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs            = data.aws_availability_zones.available.names
  public_subnets = var.public_subnets

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}