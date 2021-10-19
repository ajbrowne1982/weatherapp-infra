### Define Variables
variable "bucket" {
  default = ""
}

variable "tags" {
  default = {}
}

### Create Resources
resource "aws_s3_bucket" "this" {
  bucket = var.bucket
  acl    = "private"

  tags = var.tags
}

#Create bucket policy
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::127311923021:root"
        },
        "Action" : "s3:PutObject",
        "Resource" : "arn:aws:s3:::${var.bucket}/alb-logs/AWSLogs/152848913167/*"
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "delivery.logs.amazonaws.com"
        },
        "Action" : "s3:PutObject",
        "Resource" : "arn:aws:s3:::${var.bucket}/alb-logs/AWSLogs/152848913167/*",
        "Condition" : {
          "StringEquals" : {
            "s3:x-amz-acl" : "bucket-owner-full-control"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "delivery.logs.amazonaws.com"
        },
        "Action" : "s3:GetBucketAcl",
        "Resource" : "arn:aws:s3:::${var.bucket}"
      }
    ]
  })
}

### Define Output
output "s3_bucket_name" {
  description = "The name of the bucket"
  value       = aws_s3_bucket.this.id
}

output "s3_bucket_name_arn" {
  description = "The name of the bucket"
  value       = aws_s3_bucket.this.arn
}