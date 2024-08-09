variable "subnet_id" {
  description = "The ID of the subnet to launch the EC2 instance in"
  type        = string
}
variable "secgrp_id" {
  description = "The ID of the security group to launch the EC2 instance in"
  type        = string
}
variable "ami_id" {
  default = "ami-00060fac2f8c42d30"
  description = "ami image id"  
}
variable "instance_typevar" {
  default = "t2.micro"
  description = "choose instance type"
  
}