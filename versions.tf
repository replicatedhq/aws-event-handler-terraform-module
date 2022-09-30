terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.30.0"
    }
    archive = {
      version = "~> 2.2.0"
    }
  }

  required_version = "~> 1.0.11"

}
