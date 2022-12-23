output "app_ip" {
    value = aws_lb.default.dns_name
}
