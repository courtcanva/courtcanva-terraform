terraform {
  required_version = ">= 0.12"
}
provider "aws" {
  #  shared_credentials_file = "$HOME/jenkins/.aws/credentials"
  #  profile                 = "default"
  region = var.aws_region
  default_tags {
    tags = {
      Environment = "${var.env}"
      Project     = "Courtcanva"
    }
  }
}
terraform {
  backend "s3" {
    key            = "${var.statefilepath}"
    region         = "ap-southeast-2"
    bucket         = "cc-terraform-state-file"
    dynamodb_table = "terraform-state-locking"
    #encrypt = true # Optional, S3 Bucket Server Side Encryption
  }
}

data.aws_iam_role.ecs_task_execution_role
data.aws_iam_role_policy_attachment.ecs_task_execution_role