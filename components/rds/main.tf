resource "aws_db_subnet_group" "wordpress_db_subnet_group" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = [var.subnet1rds_id,var.subnet2rds_id]

  tags = {
    Name = "${var.project_name}-rds subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage = var.rds_allocated_storage
  storage_type      = var.rds_storage_type
  engine            = var.rds_engine
  engine_version    = var.rds_engine_version
  instance_class    = var.rds_instance_class
  identifier        = "${var.project_name}-db"
  db_name           = var.db_name
  username          = var.db_username
  password          = var.db_password
  multi_az          = false
  vpc_security_group_ids = [var.database_sg]
  db_subnet_group_name   = aws_db_subnet_group.wordpress_db_subnet_group.name
  skip_final_snapshot = true
  publicly_accessible =  false
  
}