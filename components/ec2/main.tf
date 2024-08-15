resource "aws_key_pair" "local_key" {
  key_name   = var.lkeyname
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "local_key" {
    content  = tls_private_key.rsa.private_key_pem
    filename = var.lkeyname
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.project_name}-ec2-instance-profile"
  role = var.ec2_role_name_ec
}
resource "aws_instance" "wordpressweb" {
    ami = var.ami
    instance_type = var.ec2-instance-type
    subnet_id = var.subnet1_id
    vpc_security_group_ids = [var.secgrp_id]
    key_name = var.lkeyname
    iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
    user_data = <<-EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<html><body><h1>Hello from vasnajcod for iwc my first tf ec2 complete coded with vpc sec</h1></body></html>" | sudo tee /var/www/html/index.html
sudo yum install -y aws-cli
sudo yum install -y amazon-linux-extras
sudo amazon-linux-extras enable php7.4
sudo yum clean metadata
sudo yum install php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap}
EOF
tags = {
    Name = "${var.project_name}-instance"
  }
}