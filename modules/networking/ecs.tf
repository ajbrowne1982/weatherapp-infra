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
  desired_count   = 1

  network_configuration {
    subnets          = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[2].id]
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.alb-tg.arn
    container_port   = 3000
    container_name   = "${var.myname}-${var.projectname}-ecs-container"
  }
  capacity_provider_strategy {
    base              = 0
    capacity_provider = "FARGATE"
    weight            = 100
  }
}

#ecs task
resource "aws_ecs_task_definition" "ab-ecs-task-fam" {
  family             = "${var.myname}-${var.projectname}-fam"
  execution_role_arn = aws_iam_role.ecs_role.arn
  network_mode       = "awsvpc"
  memory             = 512
  cpu                = 256
  container_definitions = jsonencode([
    {
      name   = "${var.myname}-${var.projectname}-ecs-container"
      image  = "152848913167.dkr.ecr.us-east-1.amazonaws.com/ajbrowne1982-weather-app-ecr-repo"
      cpu    = 256
      memory = 512
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    },
  ])
}
