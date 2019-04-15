data "aws_iam_policy_document" "lb_access_logs" {
  statement {
    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.load_balancer_access_logs.arn}/*",
    ]

    principals {
      identifiers = ["652711504416"]
      type        = "AWS"
    }
  }
}
