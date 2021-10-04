# # Load balancer
# resource "aws_lb" "webserver" {
#   name               = var.alb-name
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.G4S-eCustody-EC2.id]
#   subnets            = var.Publicsubnets

#   enable_deletion_protection = true
# }

# # Load balancer listener
# resource "aws_lb_listener" "webserver" {
#   load_balancer_arn = aws_lb.webserver.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:acm:ap-southeast-2:692487981792:certificate/08a86dc9-e0c0-406b-bf38-13279c9552d2"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.webserver.arn
#   }
# }

# #alb security group
# resource "aws_security_group" "alb_sg" {
#   name        = "${var.service_name}-alb-sg"
#   description = "Security group for ${var.alb-name} application loadbalancer"
#   vpc_id      = var.vpc-id

#   dynamic "ingress" {
#     for_each = var.ingress_ports
#     content {
#       from_port   = ingress.value.port
#       to_port     = ingress.value.port
#       protocol    = "tcp"
#       cidr_blocks = [ingress.value.cidr_block]
#     }
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = var.tags
# }

# #outputs
# output "target_group_arns" {
#   value = aws_lb_target_group.alb_target_group.*.arn
# }

# output "alb_dns_address" {
#   value = aws_lb.alb.dns_name
# }

# output "alb_name" {
#   value = aws_lb.alb.name
# }

# output "alb_zone_id" {
#   value = aws_lb.alb.zone_id
# }

# output alb_sg_id {
#   value = aws_security_group.alb_sg.id
# }