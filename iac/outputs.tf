output "api_url" {
  description = "URL pública de la API de Monitoreo"
  value       = aws_apigatewayv2_api.monitoring_api.api_endpoint
}

output "ecr_repository_url" {
  value = aws_ecr_repository.monitoring_api.repository_url
}