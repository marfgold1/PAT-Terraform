resource "aws_security_group" "lb" {
    name = "pat-lb-fw"
    vpc_id = aws_vpc.default.id

    ingress {
        protocol = "tcp"
        from_port = var.app.port
        to_port = var.app.port
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "app" {
    name = "pat-app-fw"
    vpc_id = aws_vpc.default.id

    ingress {
        protocol = "tcp"
        from_port = var.app.internal_port
        to_port = var.app.internal_port
        security_groups = [ aws_security_group.lb.id ]
    }

    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}
