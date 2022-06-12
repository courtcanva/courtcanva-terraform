terraform {
  required_version = ">= 0.12"
}
provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  #  profile                 = "default"
  region = var.aws_region
  default_tags {
    tags = {
      Environment = "UAT"
      Project = "Courtcanva"
    }
  }
}
terraform {
  backend "s3" {
    key = "uat/backend/terraform.tfstate"
    region = "ap-southeast-1"
    bucket = "cc-terraform-state-file"
    dynamodb_table = "terraform-state-locking"
    #encrypt = true # Optional, S3 Bucket Server Side Encryption
  }
}
