terraform {
  required_version = "~>1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.58.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
    }
  }
}


provider "aws" {
  region = var.region
}

provider "archive" {}
