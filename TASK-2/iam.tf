data "template_file" "policy" {
  template = file("./es_policy.json")

  vars = {
    s3_bucket_arn = aws_s3_bucket.logs.arn
  }
}

resource "aws_iam_policy" "policy" {
  name        = "elb-logs-to-elasticsearch"
  path        = "/"
  description = "Policy for elb-logs-to-elasticsearch Lambda function"
  policy      = data.template_file.policy.rendered
}

resource "aws_iam_role" "role" {
  name = "elb-logs-to-elasticsearch"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}
