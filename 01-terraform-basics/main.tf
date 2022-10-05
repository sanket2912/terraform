terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.30"
    }
  }
}
 
provider "aws" {
  region = "us-east-1"
}