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
#variable "secmng_arn" {}
variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_username" {
  description = "The username for the database"
  type        = string
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}
variable "rds_allocated_storage"{}
variable "rds_storage_type" {}
variable "rds_engine" {}
variable "rds_engine_version" {}
variable "rds_instance_class" {}