resource "aws_cloudwatch_dashboard" "monitoring_dashboard" {
  dashboard_name = "System-Health-Dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            [ "AWS/Lambda", "Invocations", "FunctionName", aws_lambda_function.monitoring_api.function_name ]
          ]
          period = 60
          stat   = "Sum"
          region = "us-east-1"
          title  = "Tickets Recibidos (Por Minuto)"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            [ "AWS/Lambda", "Errors", "FunctionName", aws_lambda_function.monitoring_api.function_name, { "color": "#d62728" } ]
          ]
          period = 60
          stat   = "Sum"
          region = "us-east-1"
          title  = "Errores Críticos"
        }
      }
    ]
  })
}