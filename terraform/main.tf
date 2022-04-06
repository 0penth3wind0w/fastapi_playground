data "archive_file" "studygroup_source" {
  type        = "zip"
  source_dir  = "${path.module}/fastapi"
  output_path = "${path.module}/fastapi.zip"
}

# Lambda
resource "aws_lambda_function" "studygroup_lambda" {
  function_name    = "${var.project}-${var.environment}-studygroup"
  handler          = "main.handler"
  runtime          = "python3.9"
  role             = aws_iam_role.studygroup_lambda_role.arn
  filename         = "${data.archive_file.studygroup_source.output_path}"
  source_code_hash = "${data.archive_file.studygroup_source.output_base64sha256}"
  timeout          = 900
}

resource "aws_iam_role" "studygroup_lambda_role" {
  name = "${var.project}-${var.environment}-studygroup"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "studygroup_lambda_policy" {
  role       = aws_iam_role.studygroup_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# API Gateway

resource "aws_apigatewayv2_api" "studygroup_lambda" {
  name          = "${var.project}-${var.environment}-studygroup"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "studygroup_lambda" {
  api_id             = aws_apigatewayv2_api.studygroup_lambda.id
  integration_uri    = aws_lambda_function.studygroup_lambda.invoke_arn
  integration_type   = "AWS_PROXY"
}

# Problem: not working when name is not $default
resource "aws_apigatewayv2_stage" "studygroup_lambda" {
  api_id      = aws_apigatewayv2_api.studygroup_lambda.id
  name        = "$default"
  auto_deploy = true
}

# API Gateway - routes

resource "aws_apigatewayv2_route" "studygroup_lambda_root" {
  api_id = aws_apigatewayv2_api.studygroup_lambda.id
  route_key = "GET /"
  target    = "integrations/${aws_apigatewayv2_integration.studygroup_lambda.id}"
}

resource "aws_apigatewayv2_route" "studygroup_lambda_chucknorris" {
  api_id = aws_apigatewayv2_api.studygroup_lambda.id
  route_key = "GET /chucknorris"
  target    = "integrations/${aws_apigatewayv2_integration.studygroup_lambda.id}"
}

resource "aws_apigatewayv2_route" "studygroup_lambda_docs" {
  api_id = aws_apigatewayv2_api.studygroup_lambda.id
  route_key = "GET /docs"
  target    = "integrations/${aws_apigatewayv2_integration.studygroup_lambda.id}"
}

resource "aws_apigatewayv2_route" "studygroup_lambda_openapi" {
  api_id = aws_apigatewayv2_api.studygroup_lambda.id
  route_key = "GET /openapi.json"
  target    = "integrations/${aws_apigatewayv2_integration.studygroup_lambda.id}"
}

# Lambda permission for routes

resource "aws_lambda_permission" "studygroup_lambda_root" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.studygroup_lambda.execution_arn}/*/GET/"
}

resource "aws_lambda_permission" "studygroup_lambda_chucknorris" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.studygroup_lambda.execution_arn}/*/GET/chucknorris"
}


resource "aws_lambda_permission" "studygroup_lambda_docs" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.studygroup_lambda.execution_arn}/*/GET/docs"
}


resource "aws_lambda_permission" "studygroup_lambda_openapi" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.studygroup_lambda.execution_arn}/*/GET/openapi.json"
}