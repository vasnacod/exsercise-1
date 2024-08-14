resource "aws_db_subnet_group" "wordpress_db_subnet_group" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = [var.subnet1rds_id]

  tags = {
    Name = "${var.project_name}-rds subnet group"
  }
}

resource "aws_iam_role" "rds_role" {
  name = "${var.project_name}-rds_secretsmanager_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "rds.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_policy_attachment" {
  role     = aws_iam_role.rds_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSDataFullAccess"
}


resource "aws_db_instance" "default" {
  allocated_storage = 10
  storage_type      = "gp2"
  engine            = "mysql"
  engine_version    = "8.0.35"
  instance_class    = "db.t3.micro"
  identifier        = "${var.project_name}-db"
  manage_master_user_password = true
  master_user_secret       = var.secmng_arn
  multi_az          = false
  #vpc_security_group_ids = [aws_security_group.rds_sg.id]
  vpc_security_group_ids = [var.database_sg]
  db_subnet_group_name   = aws_db_subnet_group.wordpress_db_subnet_group.name
  skip_final_snapshot = true
}