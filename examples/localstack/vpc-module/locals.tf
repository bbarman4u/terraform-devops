locals {
  vpc_name   = "localstack-demo-vpc"
  created_by = "Terraform"
  common_tags = {
    created_by = local.created_by
  }
}