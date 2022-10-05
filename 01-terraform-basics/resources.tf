resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "sanku-bucket-3octo"
}
resource "aws_s3_bucket_versioning" "my_s3_bucket" {
  bucket = "sanku-bucket-3octo"
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_user" "my_iam_user" {
  name = "my_iam_user_abc_updated"
}
