
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
  default     = "replace-with-your-unique-bucket-name"
}

provider "aws" {
  region = var.aws_region
}
#checkov:skip=CKV2_AWS_62:No event consumer is required for this static website.
#checkov:skip=CKV_AWS_144:Cross-region replication is intentionally omitted to keep this portfolio project single-region and low-cost.
resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name

  tags = {
    Name        = "Secure-DevSecOps-Website"
    Environment = "Portfolio"
    ManagedBy   = "Terraform"
  }
}
#checkov:skip=CKV2_AWS_62:No event consumer is required for this access-log bucket.
#checkov:skip=CKV_AWS_144:Cross-region replication is intentionally omitted to keep this portfolio project single-region and low-cost.
#checkov:skip=CKV_AWS_145:SSE-S3 is retained on the server access logging destination bucket for S3 log-delivery compatibility.
resource "aws_s3_bucket" "logs" {
  bucket = "${var.bucket_name}-logs"

  tags = {
    Name        = "Secure-DevSecOps-Logs"
    Environment = "Portfolio"
    ManagedBy   = "Terraform"
  }
}
resource "aws_s3_bucket_logging" "website" {
  bucket = aws_s3_bucket.website.id

  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "s3-access-logs/"

  depends_on = [
    aws_s3_bucket_acl.logs
  ]
}
resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id

  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_lifecycle_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  rule {
    id     = "cleanup-old-website-versions"
    status = "Enabled"

    filter {}

    noncurrent_version_expiration {
      noncurrent_days = 30
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}
resource "aws_s3_bucket_lifecycle_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    id     = "expire-old-access-logs"
    status = "Enabled"

    filter {}

    expiration {
      days = 90
    }

    noncurrent_version_expiration {
      noncurrent_days = 90
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}
resource "aws_s3_bucket_public_access_block" "logs" {
  bucket = aws_s3_bucket.logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
#checkov:skip=CKV2_AWS_65:ACLs are retained on the server access logging destination bucket to grant S3 Log Delivery permission.
resource "aws_s3_bucket_ownership_controls" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_acl" "logs" {
  bucket = aws_s3_bucket.logs.id
  acl    = "log-delivery-write"

  depends_on = [
    aws_s3_bucket_ownership_controls.logs
  ]
}
resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
resource "aws_s3_bucket_versioning" "website" {
  bucket = aws_s3_bucket.website.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "website" {
  bucket = aws_s3_bucket.website.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
