provider "aws" {

  region = "ap-southeast-2"
  #shared_credentials_file = "%USERPROFILE%/.aws/credentials"
}

provider "mongodbatlas" {
  public_key  = var.public_key
  private_key = var.private_key
}

resource "mongodbatlas_project" "aws_atlas" {
  name   = var.mongodbprojectname
  org_id = var.atlasorgid
}

resource "mongodbatlas_cluster" "cluster-atlas" {
  project_id = mongodbatlas_project.aws_atlas.id
  name       = var.clustername
  # Provider Settings "block"
  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name        = "AP-SOUTHEAST-2"
  provider_instance_size_name = "M2"
}
//Creating the DB user + assigning permissions
resource "mongodbatlas_database_user" "db-user" {
  username           = var.atlas_dbuser
  password           = var.atlas_dbpassword
  auth_database_name = "admin"
  project_id         = mongodbatlas_project.aws_atlas.id
  roles {
    role_name     = "readWriteAnyDatabase"
    database_name = "admin"
  }
  depends_on = [mongodbatlas_project.aws_atlas]
}
/*resource "mongodbatlas_network_container" "atlas_container" {
  atlas_cidr_block = var.atlas_vpc_cidr
  project_id       = mongodbatlas_project.aws_atlas.id
  provider_name    = "AWS"
  region_name      = var.atlas_region
}

data "mongodbatlas_network_container" "atlas_container" {
  container_id = mongodbatlas_network_container.atlas_container.container_id
  project_id   = mongodbatlas_project.aws_atlas.id
}

resource "mongodbatlas_network_peering" "aws-atlas" {
  accepter_region_name   = var.aws_region
  project_id             = mongodbatlas_project.aws_atlas.id
  container_id           = mongodbatlas_network_container.atlas_container.container_id
  provider_name          = "AWS"
  route_table_cidr_block = aws_vpc.primary.cidr_block
  vpc_id                 = aws_vpc.primary.id
  aws_account_id         = var.aws_account_id
}*/

resource "mongodbatlas_project_ip_access_list" "acllist" {
  project_id = mongodbatlas_project.aws_atlas.id
  cidr_block = var.ECSNatGatewayEIP
  comment    = "Add ECS NAT Gateway EIP"
}
