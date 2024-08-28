#S3 Bucket for wildfly domain discovery
resource "aws_s3_bucket" "s3_bucket" {
  count = var.s3_bucket_exists == false ? 1 : 0
  bucket = var.s3_domain_bucket

  force_destroy = true

  tags = {
    Environment = var.env
  }
}

#S3 Bucket Server Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "s3bucket_encryption" {
  count = var.s3_bucket_exists == false ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

# S3 Bucket Level Public Access
resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access" {
  bucket = aws_s3_bucket.s3_bucket[0].id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

#Apply Bucket Policy to S3 Bucket
resource "aws_s3_bucket_policy" "s3bucket_policy" {
  count = var.s3_bucket_exists == false ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket[0].id
  policy = file("bucket-policy.json")

  depends_on = [aws_s3_bucket_server_side_encryption_configuration.s3bucket_encryption, aws_s3_bucket_public_access_block.s3_bucket_public_access]
}

