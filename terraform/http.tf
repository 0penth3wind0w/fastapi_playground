# API Gateway - HTTP ===============================================================

resource "aws_apigatewayv2_api" "studygroup_lambda" {
  name          = "${var.project}-${var.environment}-studygroup-http"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "studygroup_lambda" {
  api_id             = aws_apigatewayv2_api.studygroup_lambda.id
  integration_uri    = aws_lambda_function.studygroup_lambda.invoke_arn
  integration_type   = "AWS_PROXY"
}

# # Problem: not working when name is not $default
resource "aws_apigatewayv2_stage" "studygroup_lambda" {
  api_id      = aws_apigatewayv2_api.studygroup_lambda.id
  name        = "$default"
  auto_deploy = true
}

# API Gateway - routes

resource "aws_apigatewayv2_route" "studygroup_lambda_root" {
  api_id    = aws_apigatewayv2_api.studygroup_lambda.id
  route_key = "GET /"
  target    = "integrations/${aws_apigatewayv2_integration.studygroup_lambda.id}"
}

resource "aws_apigatewayv2_route" "studygroup_lambda_yomomma" {
  api_id    = aws_apigatewayv2_api.studygroup_lambda.id
  route_key = "GET /yomomma"
  target    = "integrations/${aws_apigatewayv2_integration.studygroup_lambda.id}"
}

resource "aws_apigatewayv2_route" "studygroup_lambda_something_post" {
  api_id    = aws_apigatewayv2_api.studygroup_lambda.id
  route_key = "POST /something"
  target    = "integrations/${aws_apigatewayv2_integration.studygroup_lambda.id}"
}

resource "aws_apigatewayv2_route" "studygroup_lambda_something_put" {
  api_id    = aws_apigatewayv2_api.studygroup_lambda.id
  route_key = "PUT /something/{uid}"
  target    = "integrations/${aws_apigatewayv2_integration.studygroup_lambda.id}"
}

resource "aws_apigatewayv2_route" "studygroup_lambda_something_delete" {
  api_id    = aws_apigatewayv2_api.studygroup_lambda.id
  route_key = "DELETE /something/{uid}"
  target    = "integrations/${aws_apigatewayv2_integration.studygroup_lambda.id}"
}

resource "aws_apigatewayv2_route" "studygroup_lambda_something_patch" {
  api_id    = aws_apigatewayv2_api.studygroup_lambda.id
  route_key = "PATCH /something/{uid}"
  target    = "integrations/${aws_apigatewayv2_integration.studygroup_lambda.id}"
}

resource "aws_apigatewayv2_route" "studygroup_lambda_docs" {
  api_id    = aws_apigatewayv2_api.studygroup_lambda.id
  route_key = "GET /docs"
  target    = "integrations/${aws_apigatewayv2_integration.studygroup_lambda.id}"
}

resource "aws_apigatewayv2_route" "studygroup_lambda_openapi" {
  api_id    = aws_apigatewayv2_api.studygroup_lambda.id
  route_key = "GET /openapi.json"
  target    = "integrations/${aws_apigatewayv2_integration.studygroup_lambda.id}"
}

resource "aws_apigatewayv2_route" "studygroup_lambda_proxy" {
  api_id    = aws_apigatewayv2_api.studygroup_lambda.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.studygroup_lambda.id}"
}

# Lambda permission for routes

resource "aws_lambda_permission" "studygroup_lambda_root" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.studygroup_lambda.execution_arn}/*/GET/"
}

resource "aws_lambda_permission" "studygroup_lambda_yomomma" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.studygroup_lambda.execution_arn}/*/GET/yomomma"
}

resource "aws_lambda_permission" "studygroup_lambda_something_post" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.studygroup_lambda.execution_arn}/*/POST/something"
}

resource "aws_lambda_permission" "studygroup_lambda_something_put" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.studygroup_lambda.execution_arn}/*/PUT/something/{uid}"
}

resource "aws_lambda_permission" "studygroup_lambda_something_delete" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.studygroup_lambda.execution_arn}/*/DELETE/something/{uid}"
}

resource "aws_lambda_permission" "studygroup_lambda_something_patch" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.studygroup_lambda.execution_arn}/*/PATCH/something/{uid}"
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

resource "aws_lambda_permission" "studygroup_lambda_proxy" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.studygroup_lambda.execution_arn}/*/*/*"
}
