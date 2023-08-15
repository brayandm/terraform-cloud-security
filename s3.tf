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
	Owner 		= "Github"
	Compliance  = "GDPR"
  }
}
