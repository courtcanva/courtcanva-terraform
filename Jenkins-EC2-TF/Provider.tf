terraform {
  required_providers {
    aws = {
      source ="hashicorp/aws"
      version = ">=2.7.0"
    }
  }
}
provider "aws" {
#  shared_credentials_file = "$HOME/jenkins/.aws/credentials"
#  profile                 = "default"

  region = var.aws_region
default_tags {
    tags = {
      name = "JenkinsEC2"
      Project        = "Courtcanva"
    }
  }

}

terraform {
  backend "s3" {
    bucket         = "cc-tfstate-for-pipeline"
    key            = "UAT/JenkinsEC2/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "cc-infra-tfstate"
  }
}


data "aws_availability_zones" "available" {}


