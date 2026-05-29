locals {
  common_tags = {
    Project = var.project_tag
  }
}

resource "aws_s3_bucket" "storage" {
  bucket = var.bucket_name
  tags   = local.common_tags
}

resource "aws_s3_bucket_public_access_block" "storage" {
  bucket = aws_s3_bucket.storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
