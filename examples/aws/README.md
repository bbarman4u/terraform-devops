# aws

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

# Getting Started
## Local Configurations
- Note: The code works for region - `us-west-2`
- To use the code as is, set up AWS Profile named `plural` and substitute your own access keys and id: 
  `aws configure --profile plural`
  - Example:
    ```
    AWS Access Key ID [None]: <enter access key id>
    AWS Secret Access Key [None]: <enter secret access key>
    Default region name [None]: us-west-2
    Default output format [None]:
    ```
## Terraform Changes
- Terraform providers block 
- Important notes: 
    - note the aws profile `plural` created above being referenced here
    - due to a version incompatibility between localstack and aws provider version, the aws provider version is pinned to `4.34.0`. Please follow the [specific issue here](https://github.com/localstack/localstack/issues/7046). You can use a higher version if not using localstack.
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
}


```
- Run your regular terraform workflow commands in the respective example module folders such as :
```
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply

```

# References