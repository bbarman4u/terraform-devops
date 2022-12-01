# Create VPC Terraform Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"
  #version = "~> 2.78"

  # VPC Basic Details
  name = "${local.vpc_name}-${var.environment}"
  cidr = var.vpc_cidr_block

  azs             = var.vpc_availability_zones
  private_subnets = var.vpc_private_subnets

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags     = local.common_tags
  vpc_tags = local.common_tags

  private_subnet_tags = {
    Type = "Private Subnets"
  }
}