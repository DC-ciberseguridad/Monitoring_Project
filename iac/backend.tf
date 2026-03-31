#Este bucket guarda el estado de Terraform para que lo consulte de forma automatica

terraform {
  backend "s3" {
    bucket  = "state-terraform-monitoring"
    key     = "monitoring/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}  