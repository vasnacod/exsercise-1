
resource "aws_security_group" "rds_sg" {
  name = "wordpress-rds-sg"

  vpc_id = var.rds_vpc

  # Add any additional ingress/egress rules as needed
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_db_subnet_group" "wordpress_db_subnet_group" {
  name       = "wordprees-db-subnet-group"
  subnet_ids = [var.subnet1rds_id]

  tags = {
    Name = "my rds db subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage = 10
  storage_type      = "gp2"
  engine            = "mysql"
  engine_version    = "8.0.35"
  instance_class    = "db.t3.micro"
  identifier        = "mywpdb"
  username          = var.db_username
  password          = var.db_password
  multi_az          = false

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.wordpress_db_subnet_group.name

  skip_final_snapshot = true
}