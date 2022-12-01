locals {
  vpc_name   = "demo-vpc"
  created_by = "Terraform"
  common_tags = {
    created_by = local.created_by
  }
}