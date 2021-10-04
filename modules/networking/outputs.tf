### Define Output
output "vpc" {
  description = "The VPC ID"
  value       = aws_vpc.vpc.id
}