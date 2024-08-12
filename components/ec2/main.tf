resource "aws_key_pair" "local_key" {
  key_name   = "local_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "local_key" {
    content  = tls_private_key.rsa.private_key_pem
    filename = "local_key"
}
resource "aws_instance" "wordpressweb" {
    ami = var.ami_id
    instance_type = var.instance_typevar
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.secgrp_id]
    key_name = "local_key"
    user_data = <<-EOF
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<html><body><h1>Hello from vasnajcod for iwc my first tf ec2 complete coded with vpc sec</h1></body></html>" | sudo tee /var/www/html/index.html
              sudo yum install aws-cli
              EOF
}