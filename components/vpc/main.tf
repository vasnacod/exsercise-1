resource "aws_vpc" "wordpressvpc" {
    cidr_block = var.cidrvpc

    tags = {
    Name = "wordpress_vpc"
  }
  
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.wordpressvpc.id
  cidr_block              = var.subnet1
  availability_zone       = var.azzonea
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.wordpressvpc.id
  cidr_block              = var.subnet2
  availability_zone       = var.azzonea
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.wordpressvpc.id
  tags = {
    Name = "wordpres_igw"
  }
}

resource "aws_route_table" "wordpressrt" {
  vpc_id = aws_vpc.wordpressvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "wordpressrtrta2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.wordpressrt.id
}

resource "aws_security_group" "http" {
  name   = "webwordpress"
  vpc_id = aws_vpc.wordpressvpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  /* ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } */

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wordpress-sg"
  }
}