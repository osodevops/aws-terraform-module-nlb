resource "aws_lb_target_group" "load_balancer" {
  name     = "${local.lb_tag_name}-TG"
  port     = lookup(var.target_group, "backend_port")
  protocol = upper(lookup(var.target_group, "backend_protocol"))
  vpc_id   = var.vpc_id

  deregistration_delay = lookup(var.target_group, "deregistration_delay", lookup(local.target_groups_defaults, "deregistration_delay"))
  target_type          = lookup(var.target_group, "target_type", lookup(local.target_groups_defaults, "target_type"))
  slow_start           = lookup(var.target_group, "slow_start", lookup(local.target_groups_defaults, "slow_start"))

  health_check {
    interval            = lookup(var.target_group, "health_check_interval", lookup(local.target_groups_defaults, "health_check_interval"))
    port                = lookup(var.target_group, "health_check_port", lookup(local.target_groups_defaults, "health_check_port"))
    healthy_threshold   = lookup(var.target_group, "health_check_healthy_threshold", lookup(local.target_groups_defaults, "health_check_healthy_threshold"))
    unhealthy_threshold = lookup(var.target_group, "health_check_unhealthy_threshold", lookup(local.target_groups_defaults, "health_check_unhealthy_threshold"))
    protocol            = upper(lookup(var.target_group, "healthcheck_protocol", lookup(var.target_group, "backend_protocol")))
  }


  tags = merge(var.common_tags, map("Name", "${local.lb_tag_name}-TG"))

  depends_on = ["aws_lb.load_balancer"]
}
