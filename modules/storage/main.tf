resource "aws_s3_bucket" "assets" {
  bucket = var.bucket_name

  tags = {
    Name        = "Project Assets"
    Environment = "Dev"
  }
}

# Optional: Block public access (Good Security practice!)
resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.assets.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}