resource "aws_lb" "load_balancer" {
  name               = local.lb_tag_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets            = [var.subnets]

  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_deletion_protection       = var.deletion_protection

  access_logs {
    bucket  = aws_s3_bucket.load_balancer_access_logs.bucket
    prefix  = var.s3_logs_prefix
    enabled = true
  }

  tags = merge(var.common_tags, map("Name", local.lb_tag_name))
}
