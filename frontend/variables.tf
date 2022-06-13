variable "environment" {
  type        = string
  description = "The environment (uat, prod, test, etc.)  for the website."
}

variable "domain_name" {
  type        = string
  description = "The domain name for the website."

}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."

}

variable "common_tags" {
  description = "Common tags you want applied to all components."
}

variable "zone_id" {
  description = "The id of your hosted zone you want to apply for your project."
  type        = string

}

variable "region" {
  type = string
}

variable "aw_static_web" {
  description = "Front-End S3 name"
  type        = string
}
variable "statefilepath" {
  type = string
}


