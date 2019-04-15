variable "account_name" {
  type = "string"
}

variable "common_tags" {
  type = "map"
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  default = false
}

variable "dns_name" {
  description = "DNS entry to use for load_balancer in Route53 Domain"
  default = "nlb"
}

variable "dns_zone_id" {
  description = "Route53 DNS Zone ID for load balancer fqdn"
}

variable "enable_cross_zone_load_balancing" {
  description = "Enable cross AZ load balancing on the LB"
  default = false
}

variable "environment" {
  type = "string"
  default = "P"
}

variable "load_balancer_type" {
  description = "account_name or network"
  default = "network"
}

variable "internal" {
  description = "Internal or internet-facing"
  default = false
}

variable "listener" {
  type = "map"
  default = {
    port = "443"
    protocol = "TCP"
  }
}

variable "name" {
  description = "Load Balancer Name"
}

variable "s3_force_destroy" {
  default = "false"
}

variable "s3_logs_prefix" {
  description = "Load Balancer access logs S3 prefix"
  default = "lb-access-logs"
}

variable "security_groups" {
  description = "List of Security Groups to add to the  instances"
  type = "list"
  default = [ ]
}

variable "subnets" {
  description = "Subnets to create Load Balancer on"
  type = "list"
}

variable "target_group" {
  type = "map"
  default = { 
      backend_port     = "443"
      backend_protocol = "HTTPS"
  }
}

variable "vpc_id" {
  description = "AWS VPC id to create target group in"
}

locals {
  lb_tag_name = "${var.environment}-${upper(var.account_name)}-${var.internal ? "PRI" : "PUB"}-${upper(var.name)}-${var.load_balancer_type == "network" ?  "NLB" : "ALB"}"
  listener_defaults = {
    port            = "443"
    protocol        = "TCP"
  }
  target_groups_defaults = {
    cookie_duration                  = 86400
    deregistration_delay             = 300
    health_check_interval            = 10
    health_check_healthy_threshold   = 3
    health_check_path                = "/"
    health_check_port                = "traffic-port"
    health_check_timeout             = 5
    health_check_unhealthy_threshold = 3
    health_check_matcher             = "200-299"
    slow_start                       = 0
    stickiness_enabled               = true
    target_type                      = "instance"
  }
}
