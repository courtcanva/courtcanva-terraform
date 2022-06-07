terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.aws_region
default_tags {
    tags = {
      name = "JenkinsEC2"
      Project        = "Courtcanva"
    }
  }

}

data "aws_availability_zones" "available" {}


