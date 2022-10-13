variable "application_name" {
  default = "07-backend-state"
}
variable "project_name" {
  default = "users"
}
variable "environment" {
  default = "dev"
}
terraform {
  backend "s3" {
    bucket = "application-name-backend-state-sanku13oct"
    #key            = "${var.application_name}-${var.project_name}-${var.environment}"
    key            = "07-backend-state/users/backend-state"
    region         = "us-east-1"
    dynamodb_table = "dev_application_locks"
    encrypt        = true
  }
}
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

resource "aws_iam_user" "my_iam_user" {
  name = "${terraform.workspace}_my_iam_user_abc"
}
