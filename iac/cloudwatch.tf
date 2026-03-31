# 1. Crear el canal de comunicación (SNS)
resource "aws_sns_topic" "alerts" {
  name = "monitoring-alerts-topic"
}

# 2. Suscribir tu correo (Tendrás que confirmar el mail que te llegue)
resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "pepitosouls2020@gmail.com" # CAMBIA ESTO
}

# 3. Tu alarma mejorada
resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name          = "lambda-errors-alert"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  alarm_description   = "Esta alarma se activa si hay más de 5 errores en 1 minuto"
  
  # CONEXIÓN: Qué hacer cuando se active
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn] # Avisa cuando el sistema vuelve a la normalidad

  dimensions = {
    FunctionName = aws_lambda_function.monitoring_api.function_name
  }
}