output "subnet1_id" {
  value = aws_subnet.public_subnet_az1_cidr.id
}
output "subnet2_id" {
  value = aws_subnet.private_data_subnet_az1_cidr.id
}
output "subnet3_id" {
  value = aws_subnet.private_data_subnet_az2_cidr.id
}
output "securigroup_id" {
  value = aws_security_group.secgrupwp.id
}
output "wpvpc_id" {
  value = aws_vpc.wordpressvpc.id
}
output "databaserds_sg" {
  value = aws_security_group.database_sg.id  
}
output "ec2_role_name_vpc" {
  value = aws_iam_role.ec2_role.name
}