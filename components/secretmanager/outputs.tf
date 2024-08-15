output "secret_arn" {
  value = aws_secretsmanager_secret.smanager.arn
}

output "secret_name" {
  value = aws_secretsmanager_secret.smanager.name
}

output "smdb_name" {
  value = jsondecode(aws_secretsmanager_secret_version.smanagerver.secret_string)["name"]
  sensitive = true
}

output "smdb_username" {
  value = jsondecode(aws_secretsmanager_secret_version.smanagerver.secret_string)["username"]
  sensitive = true
}

output "smdb_password" {
  value = jsondecode(aws_secretsmanager_secret_version.smanagerver.secret_string)["password"]
  sensitive = true
}