# Localstack
LocalStack is a cloud service emulator that runs in a single container on your laptop or in your CI environment. With LocalStack, you can run your AWS applications or Lambdas entirely on your local machine without connecting to a remote cloud provider! Whether you are testing complex CDK applications or Terraform configurations, or just beginning to learn about AWS services, LocalStack helps speed up and simplify your testing and development workflow.

Localstack is great for early validation of the code without needing a live AWS environment.

# Installation
## Pre-requisites
Please make sure to install the following tools on your machine before moving on:

- python (Python 3.7 up to 3.10 is supported)
- pip (Python package manager)
- docker
## Required Tools for Development
### AWS CLI
- Please reference the steps [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
### Terraform CLI
- Please reference the steps [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
### Localstack
- Please reference the steps [here](https://docs.localstack.cloud/get-started/#installation)

# Getting Started
## What examples are included that work with community version of localstack
- ec2
- s3-sqs
## Local Configurations
- Set up AWS Profile for localstack amd enter following values: `aws configure --profile localstack`
    ```
    AWS Access Key ID [None]: test
    AWS Secret Access Key [None]: test
    Default region name [None]: us-east-1
    Default output format [None]:
    ```
- Start Localstack in a new terminal:  `python3 -m localstack.cli.main start`
## Terraform Changes
- Terraform providers block 
- Important notes: 
    - note the aws profile `localstack` created above being referenced here
    - due to a version incompatibility between localstack and aws provider version, the aws provider version is pinned to `4.34.0`. Please follow the [specific issue here](https://github.com/localstack/localstack/issues/7046)
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.34.0" #"~> 4.44.0"
    }
  }

  required_version = ">= 1.0.0"
}

provider "aws" {
  profile = "localstack"
  s3_use_path_style         = false
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints {
    apigateway     = "http://localhost:4566"
    apigatewayv2   = "http://localhost:4566"
    cloudformation = "http://localhost:4566"
    cloudwatch     = "http://localhost:4566"
    dynamodb       = "http://localhost:4566"
    ec2            = "http://localhost:4566"
    es             = "http://localhost:4566"
    elasticache    = "http://localhost:4566"
    firehose       = "http://localhost:4566"
    iam            = "http://localhost:4566"
    kinesis        = "http://localhost:4566"
    lambda         = "http://localhost:4566"
    rds            = "http://localhost:4566"
    redshift       = "http://localhost:4566"
    route53        = "http://localhost:4566"
    s3             = "http://s3.localhost.localstack.cloud:4566"
    secretsmanager = "http://localhost:4566"
    ses            = "http://localhost:4566"
    sns            = "http://localhost:4566"
    sqs            = "http://localhost:4566"
    ssm            = "http://localhost:4566"
    stepfunctions  = "http://localhost:4566"
    sts            = "http://localhost:4566"
  }
}


```
## Usage
- Run your regular terraform workflow commands in the respective example module folders such as :
```
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply

```


# References