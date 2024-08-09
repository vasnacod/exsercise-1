variable "dynamotfstate" {
    default = "tfstatedb"
    description = "dynomodb for tfstate locking state"
    type = string 
}

variable "s3tfstate" {
    default = "exercise1-323rgr2"
    description = "s3 bucket for tfstate locking"
    type = string  
}
