provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

/*module "tfstate" {
  source = "./tfstate/"
  
}*/
/* module "secrets_manager" {
source = "./components/secreatmanager"
db_username = var.db_username
db_password = var.db_password
project_name = var.project_name
smname = var.smname
} */
/* output "smanger_arnto" {
  value = module.secrets_manager.secret_arn
}
output "smanger_nameto" {
  value = module.secrets_manager.secret_name
} */
module "s3" {
  source = "./components/s3"
  project_name = var.project_name
  s3bucketname = var.s3bucketname
  
}
module "vpc" {
  source = "./components/vpc"
  project_name = var.project_name
  cidrvpc = var.vpc_cidr
  public_subnet_az1_cidr = var.public_subnet_az1_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
  azzonea = var.azzonea
  azzoneb = var.azzoneb
  s3bucketname = var.s3bucketname
  region = var.region
  smname = var.smname
  accountid = var.accountid
}

module "rds" {
  source        = "./components/rds"
  subnet1rds_id = module.vpc.subnet2_id
  subnet2rds_id = module.vpc.subnet3_id
  rds_vpc       = module.vpc.wpvpc_id
  database_sg = module.vpc.databaserds_sg
  project_name = var.project_name
  secmng_arn = module.secreatmanager.secret_arn
}

 module "ec2" {
  source    = "./components/ec2"
  subnet1_id = module.vpc.subnet1_id
  secgrp_id = module.vpc.securigroup_id
  ami = var.ami
  ec2-instance-type = var.ec2-instance-type
  project_name = var.project_name
  ec2_role_name_ec = module.vpc.ec2_role_name_vpc
 }

/* terraform {
  backend "s3" {
    bucket         = var.s3tfstate
    key            = "tfstatelock/terraform.tfstate"
    region         = var.region
    encrypt        = true
    dynamodb_table = var.dynamotfstate
  }
} */