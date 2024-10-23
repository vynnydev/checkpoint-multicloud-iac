terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.70"
    }
  }
  backend "s3" {
    bucket         = "staticsitelbtfvinicius"
    key            = "terraform.tfstate"
    dynamodb_table = "staticsitelbtfvinicius"
    region         = "us-east-1"
  }
}

provider "aws" {
  region                   = var.aws_region
}