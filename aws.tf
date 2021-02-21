terraform {
  required_version = "0.14.7"

  required_providers {
    aws = {
      version = ">= 3.29.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.application_region
}
