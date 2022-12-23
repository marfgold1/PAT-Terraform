resource "aws_ecs_task_definition" "app" {
    family = var.app.name
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu = var.app.cpu
    memory = var.app.memory
    container_definitions = jsonencode([
        {
            image = "ghcr.io/marfgold1/arcwawan:latest"
            cpu = var.app.cpu
            memory = var.app.memory
            name = var.app.name
            networkMode = "awsvpc"
            portMappings = [
                {
                    containerPort = var.app.container_port,
                    hostPort = var.app.internal_port
                }
            ]
        }
    ])
}

resource "aws_ecs_cluster" "app" {
    name = "pat-cluster"
}

resource "aws_ecs_service" "app" {
    name = var.app.name
    cluster = aws_ecs_cluster.app.id
    task_definition = aws_ecs_task_definition.app.arn
    launch_type = "FARGATE"
    desired_count = var.app.minCount

    network_configuration {
        security_groups = [ aws_security_group.app.id ]
        subnets = aws_subnet.private.*.id
    }

    load_balancer {
        target_group_arn = aws_lb_target_group.app.id
        container_name = var.app.name
        container_port = var.app.internal_port
    }

    depends_on = [ aws_lb_listener.app ]
}
