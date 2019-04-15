resource "aws_s3_bucket" "load_balancer_access_logs" {
  bucket        = "${var.name}-${lower(var.environment)}-${data.aws_caller_identity.current.account_id}-${var.load_balancer_type == "network" ?  "nlb" : "alb"}-access-logs"
  acl           = "log-delivery-write"
  force_destroy = "${var.s3_force_destroy}"

  versioning {
    enabled = true
  }

  tags = "${merge(var.common_tags,
    map("Name", "${local.lb_tag_name}-ACCESS-LOGS-S3")
  )}"

}
