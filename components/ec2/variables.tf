variable "subnet1_id" {
  description = "The ID of the subnet to launch the EC2 instance in"
}
variable "secgrp_id" {
  description = "The ID of the security group to launch the EC2 instance in"
  type        = string
}
variable "ami" {}
variable "ec2-instance-type" {}
variable "project_name" {}
variable "ec2_role_name_ec" {}