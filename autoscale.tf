resource "aws_appautoscaling_target" "app" {
    min_capacity = var.app.minCount
    max_capacity = var.app.maxCount
    resource_id = "service/${aws_ecs_cluster.app.name}/${aws_ecs_service.app.name}"
    scalable_dimension = "ecs:service:DesiredCount"
    service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "app" {
    name = "pat-autoscale-target"
    policy_type = "TargetTrackingScaling"
    resource_id = aws_appautoscaling_target.app.resource_id
    scalable_dimension = aws_appautoscaling_target.app.scalable_dimension
    service_namespace = aws_appautoscaling_target.app.service_namespace

    target_tracking_scaling_policy_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ALBRequestCountPerTarget"
            resource_label = "app/${aws_lb.default.name}/${basename("${aws_lb.default.id}")}/targetgroup/${aws_lb_target_group.app.name}/${basename("${aws_lb_target_group.app.id}")}"
        }

        target_value = var.app.request_per_target
        scale_in_cooldown = 300
        scale_out_cooldown = 300
    }
}
