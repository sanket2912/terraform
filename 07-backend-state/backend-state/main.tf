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

//S3 bucket
resource "aws_s3_bucket" "enterprice_backend_state" {
  bucket = "application-name-backend-state-sanku13oct"
  lifecycle {
    prevent_destroy = false
  }

}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.enterprice_backend_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.enterprice_backend_state.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


//Locking - Dynamo DB
resource "aws_dynamodb_table" "enterprice_backend_lock" {
  name         = "dev_application_locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}