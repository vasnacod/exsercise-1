resource "aws_secretsmanager_secret" "smanager" {
  name        = var.smname
  description = "${var.project_name}-smng key"
}

resource "aws_secretsmanager_secret_version" "smanagerver" {
  secret_id     = aws_secretsmanager_secret.smanager.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
  })
}