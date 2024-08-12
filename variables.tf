variable "aws_profile" {}
variable "region" {}
/* variable "project" {}
variable "environment" {}
variable "created_by" {}
variable "created_tool" {} */
variable "dynamotfstate" {
  default     = "tfstatedb"
  description = "dynomodb for tfstate locking state"
  type        = string
}

variable "s3tfstate" {
  default     = "exercise1-323rgr2"
  description = "s3 bucket for exercise1"
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