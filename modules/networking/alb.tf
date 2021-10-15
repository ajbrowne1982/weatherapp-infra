

# Load balancer
resource "aws_lb" "alb" {
  name               = "${var.myname}-${var.projectname}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet[0].id, aws_subnet.public_subnet[2].id]
  enable_deletion_protection = true
  access_logs {
    bucket  = var.s3_bucket_name
    prefix  = "alb-logs"
    enabled = true
  }
  tags = var.tags
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
  tags = var.tags
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
    from_port   = var.int-port
    to_port     = var.int-port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   tags = var.tags
}
