terraform {
  required_version = ">= 0.12"
}
provider "aws" {
  #  shared_credentials_file = "$HOME/jenkins/.aws/credentials"
  #  profile                 = "default"
  region = var.aws_region
  default_tags {
    tags = {
      Environment = "UAT"
      Project     = "Courtcanva"
    }
  }
}
terraform {
  backend "s3" {
    key            = var.statefilepath
    region         = "ap-southeast-2"
    bucket         = "cc-terraform-state-file"
    dynamodb_table = "terraform-state-locking"
    #encrypt = true # Optional, S3 Bucket Server Side Encryption
  }
}
