terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.34.0" #"~> 4.44.0"
    }
  }
}

provider "aws" {
  profile = "plural"
}