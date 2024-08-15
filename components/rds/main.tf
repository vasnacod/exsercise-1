resource "aws_db_subnet_group" "wordpress_db_subnet_group" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = [var.subnet1rds_id,var.subnet2rds_id]

  tags = {
    Name = "${var.project_name}-rds subnet group"
  }
}
/* # rds role
resource "aws_iam_role" "rds_role" {
  name = "${var.project_name}-rds_secretsmanager_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "rds.amazonaws.com"
        }
      }
    ]
  })
}
# iam policy
resource "aws_iam_policy" "secrets_manager_read_only" {
  name        = "${var.project_name}-secrets-manager-rds-read"
  description = "Read access to Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}
# attach policy to role
resource "aws_iam_role_policy_attachment" "rds_secrets_manager_policy_attachment" {
  role       = aws_iam_role.rds_role.name
  policy_arn  = aws_iam_policy.secrets_manager_read_only.arn
}
 */

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
  #iam_database_authentication_enabled = true
  #manage_master_user_password = true
  #master_user_secret       = var.secmng_arn
  multi_az          = false
  #vpc_security_group_ids = [aws_security_group.rds_sg.id]
  vpc_security_group_ids = [var.database_sg]
  db_subnet_group_name   = aws_db_subnet_group.wordpress_db_subnet_group.name
  skip_final_snapshot = true
  publicly_accessible =  false
  
}