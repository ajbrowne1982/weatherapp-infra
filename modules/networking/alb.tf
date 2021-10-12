

# Load balancer
resource "aws_lb" "alb" {
  name               = "${var.myname}-${var.projectname}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet[0].id, aws_subnet.public_subnet[2].id]
  #, "aws_subnet.public_subnet.[1].id"]

  enable_deletion_protection = true
}

# # Load balancer listener
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.ext-port
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }
}

# Target group
resource "aws_lb_target_group" "alb-tg" {
  name        = "${var.myname}-${var.projectname}-tg"
  port        = var.int-port
  protocol    = var.protocol
  target_type = "ip"
  vpc_id      = aws_vpc.vpc.id
}

#alb security group
resource "aws_security_group" "alb_sg" {
  name        = var.alb-sg-name
  description = "Security group for abrowne weather app application loadbalancer"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = var.ext-port
    to_port     = var.ext-port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #   tags = var.tags
}

#outputs
output "target_group_arns" {
  value = aws_lb_target_group.alb-tg.arn
}

output "alb_dns_address" {
  value = aws_lb.alb.dns_name
}

output "alb_name" {
  value = aws_lb.alb.name
}

# output "alb_zone_id" {
#   value = aws_lb.alb.zone_id
# }

# output alb_sg_id {
#   value = aws_security_group.alb_sg.id
# }