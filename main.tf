provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

/*module "tfstate" {
  source = "./tfstate/"
  
}
module "s3" {
  source = "./components/s3"
  
}*/
/* module "vpc" {
  source = "./components/vpc"

} */

module "secrets_manager" {
  source      = "./components/secreatmanager"
  db_username = var.db_username
  db_password = var.db_password

}

/* module "rds" {
  source        = "./components/rds"
  subnet1rds_id = module.vpc.subnet1_id
  rds_vpc       = module.vpc.wpvpc_id
  db_username   = var.db_username
  db_password   = var.db_password

} */
/* module "ec2" {
  source    = "./components/ec2"
  subnet_id = module.vpc.subnet2_id
  secgrp_id = module.vpc.securigroup_id

} */

/* terraform {
  backend "s3" {
    bucket         = var.s3tfstate
    key            = "tfstatelock/terraform.tfstate"
    region         = var.region
    encrypt        = true
    dynamodb_table = var.dynamotfstate
  }
} */