#ecs cluster
resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.myname}-${var.projectname}-ecs-cluster"
  tags = {
    Name        = "${var.myname}-${var.projectname}-ecs"
    Environment = "${var.myname}-${var.projectname}"
  }
}

#ecs service
resource "aws_ecs_service" "ecs-service" {
  name            = "${var.myname}-${var.projectname}-ecs-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.ab-ecs-task-fam.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = var.private_subnets
    assign_public_ip = false
    security_groups  = [aws_security_group.ecs_sg.id]
  }
  load_balancer {
    target_group_arn = var.tg_arn
    container_port   = 3000
    container_name   = "${var.myname}-${var.projectname}-ecs-container"
  }
  tags = var.tags
}

#ecs task
resource "aws_ecs_task_definition" "ab-ecs-task-fam" {
  family             = "${var.myname}-${var.projectname}-fam"
  execution_role_arn = aws_iam_role.ecs_role.arn
  task_role_arn      = aws_iam_role.ecs_role.arn
  network_mode       = "awsvpc"
  memory             = 512
  cpu                = 256
  container_definitions = jsonencode([
    {
      "name" : "${var.myname}-${var.projectname}-ecs-container",
      "image" : "${var.ecr-repo-url}",
      "cpu" : 256,
      "memory" : 512,
      "requiresCompatibilities" : [
        "FARGATE"
      ],
      "networkMode" : "awsvpc"
      "executionRoleArn" : "{aws_iam_role.ecs_role.arn}"
      "portMappings" : [
        {
          "containerPort" : 3000,
          "hostPort" : 3000
        }
      ]
    },
  ])
}

#ecs security group
resource "aws_security_group" "ecs_sg" {
  name        = "${var.myname}-${var.projectname}-ecs-sg"
  description = "Security group for abrowne weather app ecs cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.int-port
    to_port         = var.int-port
    protocol        = "tcp"
    security_groups = [var.alb_sg]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
