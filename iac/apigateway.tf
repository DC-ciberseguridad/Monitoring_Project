# 1. Crear la API REST (HTTP API es más barata y moderna)
resource "aws_apigatewayv2_api" "monitoring_api" {
  name          = "monitoring-http-api"
  protocol_type = "HTTP"
  target        = aws_lambda_function.monitoring_api.arn
}


# 2. Permiso para que API Gateway llame a la Lambda
# Sin esto, recibirás un error 500 "Internal Server Error"
resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.monitoring_api.function_name
  principal     = "apigateway.amazonaws.com"

  # El ARN de la API que tiene permiso de invocar
  source_arn = "${aws_apigatewayv2_api.monitoring_api.execution_arn}/*/*"
}