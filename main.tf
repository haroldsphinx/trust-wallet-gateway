provider "aws" {
  region = "us-west-2" 
}

resource "aws_ecs_cluster" "app_cluster" {
  name = "app-cluster"
}

resource "aws_ecs_task_definition" "app_task_definition" {
  family                   = "app-task"
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]

  execution_role_arn = aws_iam_role.app_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "app-container"
      image     = var.docker_image
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app_service" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = ["subnet-1a2b3c4d", "subnet-5e6f7g8h"] # Replace with your subnet IDs
    security_groups = ["sg-1a2b3c4d"]                          # Replace with your security group IDs
    assign_public_ip = true
  }

  depends_on = [aws_ecs_task_definition.app_task_definition]
}

resource "aws_iam_role" "app_execution_role" {
  name = "app-execution-role"
  
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_execution_role_attachment" {
  role       = aws_iam_role.app_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
