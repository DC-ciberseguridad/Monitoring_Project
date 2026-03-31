resource "aws_dynamodb_table" "tickets" {
  name           = "tickets"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "ticket_id"

  # 1. Definición del Atributo (Correcto)
  attribute {
    name = "ticket_id"
    type = "S"
  }

  # 2. Protección contra borrado accidental (Recomendado para DBs)
  deletion_protection_enabled = false # Cambia a true en producción real

  # 3. Etiquetas (Tags) - Vital para Observabilidad y Costos
  tags = {
    Name        = "tickets-db"
    Environment = "lab-devops"
    Project     = "Monitoring_Project"
    ManagedBy   = "Terraform"
  }
}