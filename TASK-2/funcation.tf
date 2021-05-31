resource "aws_lambda_function" "logs_to_elasticsearch" {
  filename         = "./elb-logs-to-elasticsearch.zip"
  function_name    = "elb-logs-to-elasticsearch"
  description      = "elb-logs-to-elasticsearch"
  timeout          = 300
  runtime          = "nodejs12.x"
  role             = aws_iam_role.role.arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256("./elb-logs-to-elasticsearch.zip")

  environment {
    variables = {
      es_endpoint = "http://${aws_instance.logs.private_ip}:9200"
      index       = var.index
      doctype     = var.doctype
    }
  }
  vpc_config {
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = [aws_security_group.task2.id]
  }
}
resource "aws_lambda_permission" "allow" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.logs_to_elasticsearch.arn
  principal     = "s3.amazonaws.com"
  source_arn    =  aws_s3_bucket.logs.arn
} 