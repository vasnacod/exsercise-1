output "subnet1_id" {
  value = aws_subnet.subnet1.id
}
output "subnet2_id" {
  value = aws_subnet.subnet2.id
}
output "securigroup_id" {
    value = aws_security_group.secgrupwp.id
}
output "wpvpc_id" {
  value = aws_vpc.wordpressvpc.id
  
}