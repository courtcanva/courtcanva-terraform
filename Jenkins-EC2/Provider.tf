terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  shared_credentials_file = "$HOME/jenkins/.aws/credentials"
  profile                 = "default"

  region = var.aws_region
default_tags {
    tags = {
      name = "JenkinsEC2"
      Project        = "Courtcanva"
    }
  }

}

data "aws_availability_zones" "available" {}


