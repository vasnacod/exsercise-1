variable "subnet1rds_id" {
  description = "The ID of the subnet to launch the rds in"
  type        = string
}
variable "subnet2rds_id" {
  description = "The ID of the subnet to launch the rds in"
  type        = string
}
variable "rds_vpc" {
  description = "vpc id for rds to be in same vpc"
  type = string  
}
variable "project_name" {}
variable "database_sg" {}
variable "secmng_arn" {}