terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.30"
    }
  }
}

variable "names" {
  default = ["sats","ranga","tom","jane"]
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "my_iam_user" {
  count = length(var.names)
  name  = var.names[count.index]
}
