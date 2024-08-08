provider "aws" {
  region = var.region
  profile = var.aws_profile
}

module "tfstate" {
  source = "./tfstate/"
  
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