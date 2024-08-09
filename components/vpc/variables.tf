variable "cidrvpc" {
    default = "10.10.0.0/16"
    description = "cidr for wordpress vpc"
  
}
variable "subnet1" {
    default = "10.10.10.0/24"
    description = "private subnet"  
}
variable "subnet2" {
    default = "10.10.11.0/24"
    description = "public subnet"
  
}
variable "azzonea" {
    default = "eu-central-1a"
    description = "az zone for subnets"
  
}