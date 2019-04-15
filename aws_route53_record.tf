resource "aws_route53_record" "load_balancer" {
  zone_id = "${var.dns_zone_id}"
  name    = "${var.dns_name}"
  type    = "A"

  alias {
    evaluate_target_health = true
    name                   = "${aws_lb.load_balancer.dns_name}"
    zone_id                = "${aws_lb.load_balancer.zone_id}"
  }
}
