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
sudo dnf update -y
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
sudo dnf install -y httpd wget php php-{devel,mysqli,pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip}
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<html><body><h1>Hello from vasnajcod for iwc my first tf ec2 complete coded with vpc sec</h1></body></html>" | sudo tee /var/www/html/index.html
sudo dnf install https://repo.mysql.com/mysql80-community-release-el9-1.noarch.rpm
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023
sudo dnf install -y mysql-community-client
cd /home/ec2-user
wget https://wordpress.org/latest.tar.gz && tar -xzf latest.tar.gz
sudo cp -r wordpress/* /var/www/html/
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
cd /var/www/html
sudo composer require aws/aws-sdk-php
EOF
tags = {
    Name = "${var.project_name}-instance"
  }
}