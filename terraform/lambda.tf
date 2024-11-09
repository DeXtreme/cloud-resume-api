data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "../handler"
  output_path = "lambda.zip"

}


resource "aws_lambda_function" "lambda" {
  function_name = "cra-lambda"
  handler       = "handler.lambda_handler"
  role          = aws_iam_role.lambda.arn
  filename      = data.archive_file.lambda.output_path

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.9"

  vpc_config {
    subnet_ids         = [for subnet in aws_subnet.private : subnet.id]
    security_group_ids = [data.aws_security_group.private.id]
  }

  tags = {
    Name = "cra-lambda"
  }
}


resource "aws_lambda_permission" "lambda" {
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  action        = "lambda:InvokeFunction"
}
