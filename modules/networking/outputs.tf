### Define Output
output "vpc" {
  description = "The VPC ID"
  value       = aws_vpc.vpc.id
}

output "public_subnets" {
  description = "List of public subnet id"
  value       = aws_subnet.public_subnet.*.id
}

output "private_subnets" {
    description = "List of private subnet names"
    value       = aws_subnet.private_subnet.*.name
}