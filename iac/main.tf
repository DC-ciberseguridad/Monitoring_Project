provider "aws" {
  region = "us-east-1"
}

# En arquitecturas Serverless puras, AWS gestiona la red por nosotros.
# Si en el futuro quieres que tu Lambda toque una DB privada (RDS), 
# aquí configurarías la VPC. Por ahora, lo mantenemos simple y GRATIS.

# Data source para obtener el ID de la cuenta (útil para políticas)
data "aws_caller_identity" "current" {}

# Data source para la región
data "aws_region" "current" {}