variable "aws_profile" {}
variable "region" {}
variable "project_name" {}
/* variable "environment" {}
variable "created_by" {}
variable "created_tool" {} */
# vpc vars
variable "vpc_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "private_data_subnet_az1_cidr" {}
variable "private_data_subnet_az2_cidr" {}
variable "azzonea" {}
# tfstate vars
variable "dynamotfstate" {}
variable "s3tfstate" {}
# RDS vars
variable "db_username" {}
variable "db_password" {
  sensitive   = true
}
# ec2 vars
variable "ami" {}
variable "ec2-instance-type" {}
# secret manager
variable "smname" {}