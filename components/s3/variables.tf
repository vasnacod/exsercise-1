variable "wordpress-data" {
    default = "wordpressdata-vasnacod1234"
    description = "s3 bucket for wordpress site"
    type = string  
}
variable "accountid" {
    default = "1234567"
    description = "account id"
    type = number
}