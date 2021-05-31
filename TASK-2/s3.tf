// Create S3 bucket to recive ALB logs
data "aws_elb_service_account" "main" {}
resource "aws_s3_bucket" "logs" {
  acl = "private"
  force_destroy = true
  bucket = var.bucket_name
}

resource "aws_s3_bucket_policy" "logs" {
  bucket = aws_s3_bucket.logs.id

  policy = <<POLICY
{
  "Id": "Policy",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.logs.bucket}/AWSLogs/*",
      "Principal": {
        "AWS": [
          "${data.aws_elb_service_account.main.arn}"
        ]
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_notification" "elb_logs_to_elasticsearch" {
   bucket = var.bucket_name

  lambda_function {
    lambda_function_arn = aws_lambda_function.logs_to_elasticsearch.arn
    events              = ["s3:ObjectCreated:*"]
  
  }
  depends_on = [aws_s3_bucket.logs]
     
}