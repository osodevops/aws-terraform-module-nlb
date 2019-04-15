resource "aws_lb_listener" "load_balancer_listener" {
  load_balancer_arn = "${aws_lb.load_balancer.arn}"
  port              = "${lookup(var.listener, "port", lookup(local.listener_defaults, "port"))}"
  protocol          = "${lookup(var.listener, "protocol", lookup(local.listener_defaults, "protocol"))}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.load_balancer.arn}"
  }
}
