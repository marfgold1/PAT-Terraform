resource "aws_lb" "default" {
    name = "pat-lb"
    subnets = aws_subnet.public.*.id
    security_groups = [ aws_security_group.lb.id ]
}

resource "aws_lb_target_group" "app" {
    name = "pat-lb-target-group"
    port = var.app.port
    protocol = "HTTP"
    vpc_id = aws_vpc.default.id
    target_type = "ip"
}

resource "aws_lb_listener" "app" {
    load_balancer_arn = aws_lb.default.id
    port = var.app.port
    protocol = "HTTP"

    default_action {
        target_group_arn = aws_lb_target_group.app.id
        type = "forward"
    }
}
