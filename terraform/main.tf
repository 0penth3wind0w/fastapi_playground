terraform {
  required_providers {
    aws = {
      version = "4.8.0"
    }
  }
}

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
