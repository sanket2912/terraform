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
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "sanku-bucket-3octo"
}
resource "aws_s3_bucket_versioning" "my_s3_bucket" {
  bucket = "sanku-bucket-3octo"
  versioning_configuration {
    status = "Enabled"
  }
}

output "aws_s3_bucket_versioning"  {
  value=aws_s3_bucket.my_s3_bucket.versioning[0].enabled
}
output "aws_s3_bucket_complete_details"  {
  value=aws_s3_bucket.my_s3_bucket
}

resource "aws_iam_user" "my_iam_user" {
  name = "my_iam_user_abc_updated"
}
output "my_iam_user_complete_details" {
  value = aws_iam_user.my_iam_user
}