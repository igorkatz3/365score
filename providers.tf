terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
      #profile = "default"
    }
  }
  backend "s3" {
    bucket         = "terraform-state-dev365"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}



provider "aws" {
  region = var.region
  profile = "default"

  default_tags {
    tags = {
      Env = var.env
    }
  }
}




