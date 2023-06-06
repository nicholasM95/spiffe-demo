data "local_file" "hello_file" {
  filename = "hello.txt"
}

resource "aws_s3_bucket" "bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = true
}

resource "aws_s3_object" "bucket_object" {
  bucket = aws_s3_bucket.bucket.id
  key    = "hello.txt"
  source = data.local_file.hello_file.filename
}