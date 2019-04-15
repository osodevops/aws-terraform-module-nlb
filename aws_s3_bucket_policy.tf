resource "aws_s3_bucket_policy" "load_balancer_access_logs" {
  bucket = "${aws_s3_bucket.load_balancer_access_logs.id}"
  policy = "${data.aws_iam_policy_document.lb_access_logs.json}"
}
