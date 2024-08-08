variable "dynamotfstate" {
    default = "tfstatedb"
    description = "dynomodb for tfstate locking state"
    type = string 
}

variable "s3tfstate" {
    default = "tfstatelocking-323rgr2"
    description = "s3 bucket for tfstate locking"
    type = string  
}
