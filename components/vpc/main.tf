resource "aws_vpc" "wordpressvpc" {
    cidr_block = var.cidrvpc

    tags = {
    Name = "${var.project_name}-vpc"
  }
  
}

resource "aws_subnet" "public_subnet_az1_cidr" {
  vpc_id                  = aws_vpc.wordpressvpc.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = var.azzonea
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_data_subnet_az1_cidr" {
  vpc_id                  = aws_vpc.wordpressvpc.id
  cidr_block              = var.private_data_subnet_az1_cidr
  availability_zone       = var.azzonea
  map_public_ip_on_launch = false
}

resource "aws_subnet" "private_data_subnet_az2_cidr" {
  vpc_id                  = aws_vpc.wordpressvpc.id
  cidr_block              = var.private_data_subnet_az2_cidr
  availability_zone       = var.azzoneb
  map_public_ip_on_launch = false
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.wordpressvpc.id
  tags = {
    Name = "${var.project_name}-igw"
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
  subnet_id      = aws_subnet.public_subnet_az1_cidr.id
  route_table_id = aws_route_table.wordpressrt.id
}

resource "aws_security_group" "secgrupwp" {
  name   = "${var.project_name}-ec2-sg"
  vpc_id = aws_vpc.wordpressvpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-ec2-sg"
  }
}

resource "aws_security_group" "database_sg" {
  name        = "${var.project_name}-database-sg"
  description = "${var.project_name}-database-sg"
  vpc_id      = aws_vpc.wordpressvpc.id

  ingress {
    description     = "MySQL"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.secgrupwp.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-database-sg"
  }
}

# role for ec2
resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

#policy for smanager
resource "aws_iam_policy" "secretsmanager_policy" {
  name        = "${var.project_name}-secretsmanager-access"
  description = "Policy to access Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Effect = "Allow",
        Resource = "arn:aws:secretsmanager:${var.region}:${var.accountid}:secret:${var.smname}"
      }
    ]
  })
}

#policy for s3
resource "aws_iam_policy" "s3_access_policy" {
  name        = "${var.project_name}-s3-access"
  description = "Policy to access S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Effect = "Allow",
        Resource = [
          "arn:aws:s3:::${var.s3bucketname}",
          "arn:aws:s3:::${var.s3bucketname}/*"
        ]
      }
    ]
  })
}
#policy for rds
resource "aws_iam_policy" "rds_policy" {
  name        = "${var.project_name}-rds-access"
  description = "Policy for EC2 to access RDS"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "rds-db:connect"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "secretsmanager_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn  = aws_iam_policy.secretsmanager_policy.arn
}

resource "aws_iam_role_policy_attachment" "s3_access_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn  = aws_iam_policy.s3_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "rds_access_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn  = aws_iam_policy.rds_policy.arn
}