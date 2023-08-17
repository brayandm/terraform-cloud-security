resource "aws_s3_bucket" "repository_management" {
  bucket = "cloud-sec-github-repository-bucket"

  tags = {
    Name        = "Repository Management Bucket"
    Environment = "Production"
    Classified  = "Yes"
    PII         = "No"
    Purpose     = "Code Storage"
    Service     = "Repository Service"
    Backup      = "Weekly"
    Criticality = "Medium"
    Owner       = "Github"
    Compliance  = "GDPR"
  }
}

resource "aws_kms_key" "user-bucket-key" {
  description = "This key is used to encrypt bucket objects"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "user-data-encryption" {
  bucket = aws_s3_bucket.repository_management.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.user-bucket-key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning-user-data" {
  bucket = aws_s3_bucket.repository_management.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_object_lock_configuration" "user-data-lock" {
  bucket = aws_s3_bucket.repository_management.id

  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = 5
    }
  }
}

resource "aws_s3_bucket_policy" "https-only" {
  bucket = aws_s3_bucket.repository_management.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [{
        "Sid": "RestrictToTLSRequestsOnly",
        "Action": "s3:*",
        "Effect": "Deny",
        "Resource": [
            "arn:aws:s3:::repository_management",
            "arn:aws:s3:::repository_management/*"
        ],
        "Condition": {
            "Bool": {
                "aws:SecureTransport": "false"
            }
        },
        "Principal": "*"
    }]
}
EOF
}
