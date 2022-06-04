provider "aws" {
  region = var.region
  #shared_credentials_file = "%USERPROFILE%/.aws/credentials"
}

provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
  #shared_credentials_file = "%USERPROFILE%/.aws/credentials"
}