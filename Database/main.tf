terraform {
  required_providers {
    aws = {
      source ="hashicorp/aws"
      version = ">=2.7.0"
    } 
  mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }  
  }
}

provider "aws" {

  region  = "ap-southeast-2"   
  #shared_credentials_file = "%USERPROFILE%/.aws/credentials"
}

terraform {
  backend  "s3" {
 key = "uat/database/terraform.tfstate"
 region = "ap-southeast-2"
 bucket = "cc-terraform-state-file"
 dynamodb_table = "terraform-state-locking"
#encrypt = true # Optional, S3 Bucket Server Side Encryption
 }
}
