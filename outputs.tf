output "id" {
  value = aws_vpc.main.id
}

output "security_group_id" {
  value = aws_security_group.sg.id
}

output "subnets" {
  value = aws_subnet.subnets
}
