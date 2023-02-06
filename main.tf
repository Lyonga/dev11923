# AWS Lambda function
resource "aws_lambda_function" "stop_notebook" {
  function_name = "${var.account_code}-sagemaker-scheduler-${var.env}-data-science-${var.domain}-${var.category}-${var.region_code}-all"
  handler       = var.lambda_function_handler
  role          = aws_iam_role.sagemaker-scheduler-role.arn
  runtime       = var.lambda_function_runtime

  s3_bucket                      = var.lambda_function_s3_buckett
  s3_key                         = var.lambda_function_s3_key
  memory_size                    = var.lambda_function_memory_size
  timeout                        = var.lambda_function_timeout
  reserved_concurrent_executions = var.lambda_function_reserved_concurrent_executions
  tags = merge(
    {
      Name = "${var.account_code}-sagemaker-scheduler-${var.env}-data-science-${var.domain}-${var.category}-${var.region_code}-all"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}