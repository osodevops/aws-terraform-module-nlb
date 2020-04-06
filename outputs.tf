output "target_group" {
  value = aws_lb_target_group.load_balancer.arn
}

output "load_balancer_arn" {
  value = aws_lb.load_balancer.arn
}

output "load_balancer_fqdn" {
  value = aws_route53_record.load_balancer.fqdn
}
