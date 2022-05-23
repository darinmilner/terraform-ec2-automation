output "security_group_id" {
  value = aws_security_group.mtc-sg.id
}

output "subnet_id" {
  value = aws_subnet.mtc-public-subnet.id
}
