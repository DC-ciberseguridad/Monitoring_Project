#Este bucket guarda el estado de Terraform para que lo consulte de forma automatica

terraform {
  backend "s3" {
    bucket  = "terraform-state-monitoring"
    key     = "monitoring/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}  