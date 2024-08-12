output "secret_arn" {
  value = aws_secretsmanager_secret.smanager.arn
}

output "secret_name" {
  value = aws_secretsmanager_secret.smanager.name
}