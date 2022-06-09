terraform {
  required_providers {
    aws = {
      source ="hashicorp/aws"
      version = ">=2.7.0"
    }    
  }
}

provider "aws" {

  region  = "ap-southeast-2"   
  #shared_credentials_file = "%USERPROFILE%/.aws/credentials"
}