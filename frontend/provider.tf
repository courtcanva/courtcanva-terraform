terraform {
  required_version = ">= 0.12"
}
provider "aws" {
  region = var.region
  #shared_credentials_file = "%USERPROFILE%/.aws/credentials"
}

provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
  #shared_credentials_file = "%USERPROFILE%/.aws/credentials"
}

terraform {
  backend "s3" {
    key            = var.statefilepath     #"uat/frontend/terraform.tfstate"
    region         = "ap-southeast-2"
    bucket         = "cc-terraform-state-file"
    dynamodb_table = "terraform-state-locking"
    #encrypt = true # Optional, S3 Bucket Server Side Encryption
  }
}
