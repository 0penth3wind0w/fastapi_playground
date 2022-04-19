# API Gateway - REST ===============================================================
resource "aws_api_gateway_rest_api" "studygroup_lambda" {
  name = "${var.project}-${var.environment}-studygroup-rest"
}

# API Gateway - resources
# root resource will be automatically created

resource "aws_api_gateway_resource" "studygroup_lambda_yomomma" {
  parent_id   = aws_api_gateway_rest_api.studygroup_lambda.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.studygroup_lambda.id
  path_part   = "yomomma"
}

resource "aws_api_gateway_resource" "studygroup_lambda_something_post" {
  parent_id   = aws_api_gateway_rest_api.studygroup_lambda.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.studygroup_lambda.id
  path_part   = "something"
}

resource "aws_api_gateway_resource" "studygroup_lambda_something_put" {
  parent_id   = aws_api_gateway_rest_api.studygroup_lambda.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.studygroup_lambda.id
  path_part   = "something/{uid}"
}

resource "aws_api_gateway_resource" "studygroup_lambda_something_delete" {
  parent_id   = aws_api_gateway_rest_api.studygroup_lambda.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.studygroup_lambda.id
  path_part   = "something/{uid}"
}

resource "aws_api_gateway_resource" "studygroup_lambda_something_patch" {
  parent_id   = aws_api_gateway_rest_api.studygroup_lambda.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.studygroup_lambda.id
  path_part   = "something/{uid}"
}

resource "aws_api_gateway_resource" "studygroup_lambda_docs" {
  parent_id   = aws_api_gateway_rest_api.studygroup_lambda.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.studygroup_lambda.id
  path_part   = "docs"
}

resource "aws_api_gateway_resource" "studygroup_lambda_openapi" {
  parent_id   = aws_api_gateway_rest_api.studygroup_lambda.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.studygroup_lambda.id
  path_part   = "openapi.json"
}

resource "aws_api_gateway_resource" "studygroup_lambda_proxy" {
  parent_id   = aws_api_gateway_rest_api.studygroup_lambda.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.studygroup_lambda.id
  path_part   = "{proxy+}"
}

# API Gateway - method

resource "aws_api_gateway_method" "studygroup_lambda_root" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_rest_api.studygroup_lambda.root_resource_id
  rest_api_id   = aws_api_gateway_rest_api.studygroup_lambda.id
}

resource "aws_api_gateway_method" "studygroup_lambda_yomomma" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.studygroup_lambda_yomomma.id
  rest_api_id   = aws_api_gateway_rest_api.studygroup_lambda.id
}

resource "aws_api_gateway_method" "studygroup_lambda_somtthing_post" {
  authorization = "NONE"
  http_method   = "POST"
  resource_id   = aws_api_gateway_resource.studygroup_lambda_something_post.id
  rest_api_id   = aws_api_gateway_rest_api.studygroup_lambda.id
}

resource "aws_api_gateway_method" "studygroup_lambda_somtthing_put" {
  authorization = "NONE"
  http_method   = "PUT"
  resource_id   = aws_api_gateway_resource.studygroup_lambda_something_put.id
  rest_api_id   = aws_api_gateway_rest_api.studygroup_lambda.id
}

resource "aws_api_gateway_method" "studygroup_lambda_somtthing_delete" {
  authorization = "NONE"
  http_method   = "DELETE"
  resource_id   = aws_api_gateway_resource.studygroup_lambda_something_delete.id
  rest_api_id   = aws_api_gateway_rest_api.studygroup_lambda.id
}

resource "aws_api_gateway_method" "studygroup_lambda_somtthing_patch" {
  authorization = "NONE"
  http_method   = "PATCH"
  resource_id   = aws_api_gateway_resource.studygroup_lambda_something_patch.id
  rest_api_id   = aws_api_gateway_rest_api.studygroup_lambda.id
}

resource "aws_api_gateway_method" "studygroup_lambda_docs" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.studygroup_lambda_docs.id
  rest_api_id   = aws_api_gateway_rest_api.studygroup_lambda.id
}

resource "aws_api_gateway_method" "studygroup_lambda_openapi" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.studygroup_lambda_openapi.id
  rest_api_id   = aws_api_gateway_rest_api.studygroup_lambda.id
}

resource "aws_api_gateway_method" "studygroup_lambda_proxy" {
  authorization = "NONE"
  http_method   = "ANY"
  resource_id   = aws_api_gateway_resource.studygroup_lambda_proxy.id
  rest_api_id   = aws_api_gateway_rest_api.studygroup_lambda.id
}

# API Gateway - integration

resource "aws_api_gateway_integration" "studygroup_lambda_root" {
  rest_api_id             = aws_api_gateway_rest_api.studygroup_lambda.id
  resource_id             = aws_api_gateway_rest_api.studygroup_lambda.root_resource_id
  http_method             = aws_api_gateway_method.studygroup_lambda_root.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.studygroup_lambda.invoke_arn
}

resource "aws_api_gateway_integration" "studygroup_lambda_yomomma" {
  rest_api_id             = aws_api_gateway_rest_api.studygroup_lambda.id
  resource_id             = aws_api_gateway_resource.studygroup_lambda_yomomma.id
  http_method             = aws_api_gateway_method.studygroup_lambda_yomomma.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.studygroup_lambda.invoke_arn
}

resource "aws_api_gateway_integration" "studygroup_lambda_something_post" {
  rest_api_id             = aws_api_gateway_rest_api.studygroup_lambda.id
  resource_id             = aws_api_gateway_resource.studygroup_lambda_something_post.id
  http_method             = aws_api_gateway_method.studygroup_lambda_something_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.studygroup_lambda.invoke_arn
}

resource "aws_api_gateway_integration" "studygroup_lambda_something_put" {
  rest_api_id             = aws_api_gateway_rest_api.studygroup_lambda.id
  resource_id             = aws_api_gateway_resource.studygroup_lambda_something_put.id
  http_method             = aws_api_gateway_method.studygroup_lambda_something_put.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.studygroup_lambda.invoke_arn
}

resource "aws_api_gateway_integration" "studygroup_lambda_something_delete" {
  rest_api_id             = aws_api_gateway_rest_api.studygroup_lambda.id
  resource_id             = aws_api_gateway_resource.studygroup_lambda_something_delete.id
  http_method             = aws_api_gateway_method.studygroup_lambda_something_delete.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.studygroup_lambda.invoke_arn
}

resource "aws_api_gateway_integration" "studygroup_lambda_something_patch" {
  rest_api_id             = aws_api_gateway_rest_api.studygroup_lambda.id
  resource_id             = aws_api_gateway_resource.studygroup_lambda_something_patch.id
  http_method             = aws_api_gateway_method.studygroup_lambda_something_patch.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.studygroup_lambda.invoke_arn
}

resource "aws_api_gateway_integration" "studygroup_lambda_docs" {
  rest_api_id             = aws_api_gateway_rest_api.studygroup_lambda.id
  resource_id             = aws_api_gateway_resource.studygroup_lambda_docs.id
  http_method             = aws_api_gateway_method.studygroup_lambda_docs.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.studygroup_lambda.invoke_arn
}

resource "aws_api_gateway_integration" "studygroup_lambda_openapi" {
  rest_api_id             = aws_api_gateway_rest_api.studygroup_lambda.id
  resource_id             = aws_api_gateway_resource.studygroup_lambda_openapi.id
  http_method             = aws_api_gateway_method.studygroup_lambda_openapi.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.studygroup_lambda.invoke_arn
}

resource "aws_api_gateway_integration" "studygroup_lambda_proxy" {
  rest_api_id             = aws_api_gateway_rest_api.studygroup_lambda.id
  resource_id             = aws_api_gateway_resource.studygroup_lambda_proxy.id
  http_method             = aws_api_gateway_method.studygroup_lambda_proxy.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.studygroup_lambda.invoke_arn
}

# API Gateway - deployment

resource "aws_api_gateway_deployment" "studygroup_lambda" {
  rest_api_id = aws_api_gateway_rest_api.studygroup_lambda.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_rest_api.studygroup_lambda.root_resource_id,
      aws_api_gateway_method.studygroup_lambda_root.id,
      aws_api_gateway_integration.studygroup_lambda_root.id,

      aws_api_gateway_resource.studygroup_lambda_yomomma.id,
      aws_api_gateway_method.studygroup_lambda_yomomma.id,
      aws_api_gateway_integration.studygroup_lambda_yomomma.id,

      aws_api_gateway_resource.studygroup_lambda_something_post.id,
      aws_api_gateway_method.studygroup_lambda_something_post.id,
      aws_api_gateway_integration.studygroup_lambda_something_post.id,

      aws_api_gateway_resource.studygroup_lambda_something_put.id,
      aws_api_gateway_method.studygroup_lambda_something_put.id,
      aws_api_gateway_integration.studygroup_lambda_something_put.id,

      aws_api_gateway_resource.studygroup_lambda_something_delete.id,
      aws_api_gateway_method.studygroup_lambda_something_delete.id,
      aws_api_gateway_integration.studygroup_lambda_something_delete.id,

      aws_api_gateway_resource.studygroup_lambda_something_patch.id,
      aws_api_gateway_method.studygroup_lambda_something_patch.id,
      aws_api_gateway_integration.studygroup_lambda_something_patch.id,

      aws_api_gateway_resource.studygroup_lambda_docs.id,
      aws_api_gateway_method.studygroup_lambda_docs.id,
      aws_api_gateway_integration.studygroup_lambda_docs.id,

      aws_api_gateway_resource.studygroup_lambda_openapi.id,
      aws_api_gateway_method.studygroup_lambda_openapi.id,
      aws_api_gateway_integration.studygroup_lambda_openapi.id,

      aws_api_gateway_resource.studygroup_lambda_proxy.id,
      aws_api_gateway_method.studygroup_lambda_proxy.id,
      aws_api_gateway_integration.studygroup_lambda_proxy.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

# API Gateway - stage

resource "aws_api_gateway_stage" "studygroup_lambda" {
  deployment_id = aws_api_gateway_deployment.studygroup_lambda.id
  rest_api_id   = aws_api_gateway_rest_api.studygroup_lambda.id
  stage_name    = "dev"
}

# Lambda permission for routes

resource "aws_lambda_permission" "studygroup_lambda_root" {
  statement_id  = "AllowExecutionFromAPIGatewayForRoot"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${aws_api_gateway_rest_api.studygroup_lambda.id}/*/${aws_api_gateway_method.studygroup_lambda_root.http_method}/"
}

resource "aws_lambda_permission" "studygroup_lambda_yomomma" {
  statement_id  = "AllowExecutionFromAPIGatewayForYomomma"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${aws_api_gateway_rest_api.studygroup_lambda.id}/*/${aws_api_gateway_method.studygroup_lambda_yomomma.http_method}${aws_api_gateway_resource.studygroup_lambda_yomomma.path}"
}

resource "aws_lambda_permission" "studygroup_lambda_something_post" {
  statement_id  = "AllowExecutionFromAPIGatewayForSomething(POST)"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${aws_api_gateway_rest_api.studygroup_lambda.id}/*/${aws_api_gateway_method.studygroup_lambda_something_post.http_method}${aws_api_gateway_resource.studygroup_lambda_something_post.path}"
}

resource "aws_lambda_permission" "studygroup_lambda_something_post" {
  statement_id  = "AllowExecutionFromAPIGatewayForSomething(OTHER)"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${aws_api_gateway_rest_api.studygroup_lambda.id}/*/*/${aws_api_gateway_resource.studygroup_lambda_something_put.path}"
}

resource "aws_lambda_permission" "studygroup_lambda_docs" {
  statement_id  = "AllowExecutionFromAPIGatewayForDocs"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${aws_api_gateway_rest_api.studygroup_lambda.id}/*/${aws_api_gateway_method.studygroup_lambda_docs.http_method}${aws_api_gateway_resource.studygroup_lambda_docs.path}"
}

resource "aws_lambda_permission" "studygroup_lambda_openapi" {
  statement_id  = "AllowExecutionFromAPIGatewayForOpenAPI"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${aws_api_gateway_rest_api.studygroup_lambda.id}/*/${aws_api_gateway_method.studygroup_lambda_openapi.http_method}${aws_api_gateway_resource.studygroup_lambda_openapi.path}"
}

resource "aws_lambda_permission" "studygroup_lambda_proxy" {
  statement_id  = "AllowExecutionFromAPIGatewayForProxy"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.studygroup_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${aws_api_gateway_rest_api.studygroup_lambda.id}/*/*/*"
}
