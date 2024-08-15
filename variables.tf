variable "aws_profile" {}
variable "region" {}
variable "project_name" {}
variable "accountid" {}
/* variable "environment" {}
variable "created_by" {}
variable "created_tool" {} */
# vpc vars
variable "vpc_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "private_data_subnet_az1_cidr" {}
variable "private_data_subnet_az2_cidr" {}
variable "azzonea" {}
variable "azzoneb" {}
# tfstate vars
variable "dynamotfstate" {}
variable "s3tfstate" {}
# RDS vars
variable "db_name" {}
variable "db_username" {}
variable "db_password" {
  sensitive   = true
}
variable "rds_allocated_storage"{}
variable "rds_storage_type" {}
variable "rds_engine" {}
variable "rds_engine_version" {}
variable "rds_instance_class" {}
#variable "secmng_arn" {}
# ec2 vars
variable "ami" {}
variable "ec2-instance-type" {}
variable "lkeyname" {}
# secret manager
variable "smname" {}
# s3 vars
variable "s3bucketname" {}