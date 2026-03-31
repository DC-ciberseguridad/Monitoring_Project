# 1. IAM Role para la Lambda
resource "aws_iam_role" "lambda_role" {
  name = "monitoring-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# 2. Política de permisos (Logs + DynamoDB)
resource "aws_iam_policy" "lambda_policy" {
  name        = "monitoring-lambda-policy"
  description = "Permisos para escribir logs y usar DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "dynamodb:PutItem",
          "dynamodb:GetItem"
        ]
        Resource = aws_dynamodb_table.tickets.arn
      }
    ]
  })
}

# Unir Política al Role
resource "aws_iam_role_policy_attachment" "lambda_logs_dynamo" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# 3. La Función Lambda (usando imagen de ECR)
resource "aws_lambda_function" "monitoring_api" {
  function_name = "monitoring-event-processor"
  role          = aws_iam_role.lambda_role.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.monitoring_api.repository_url}:latest"

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.tickets.name
    }
  }

  # Importante para FastAPI: Aumentar el timeout por defecto (3s es muy poco)
  timeout     = 30
  memory_size = 128
}

# 4. Repositorio ECR para la Lambda
resource "aws_ecr_repository" "monitoring_api" {
  name         = "monitoring-lambda-api"
  force_delete = true
}