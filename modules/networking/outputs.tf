### Define Output
output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.vpc.id
}

output "public_subnets" {
  description = "List of public subnet id"
  value       = aws_subnet.public_subnet.*.id
}

output "private_subnets" {
  description = "List of private subnet id"
  value       = aws_subnet.private_subnet.*.id
}

output "alb_sg" {
  description = "ALB security group ID"
  value       = aws_security_group.alb_sg.id
}

output "alb_arn" {
  description = "ALB ARN"
  value       = aws_lb.alb.arn
}

output "tg_arn" {
  description = "Target group ARN"
  value       = aws_lb_target_group.alb-tg.arn
}

output "target_group_arns" {
  value = aws_lb_target_group.alb-tg.arn
}

output "alb_dns_address" {
  value = aws_lb.alb.dns_name
}

output "alb_name" {
  value = aws_lb.alb.name
}
