resource "aws_s3_bucket" "wordpressdata" {
    bucket = var.s3bucketname

  tags = {
    Name = "${var.project_name}-s3bucket"
  }
}

/* resource "aws_iam_role" "ec2_role" {
  name = "${var.wordpress-data}_ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Condition = {
          StringEquals = {
            "sts:ExternalId" = var.accountid
          }
        }
      }
    ]
  })
}
 */
/* resource "aws_iam_policy" "s3_access_policy" {
  name        = "${var.wordpress-data}_s3_access_policy"
  description = "Policy to allow EC2 instances to access S3 bucket"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Effect   = "Allow",
        Resource = [
          "${aws_s3_bucket.wordpressdata.arn}/*",
          aws_s3_bucket.wordpressdata.arn
        ]
      }
    ]
  })
} */

/* resource "aws_iam_role_policy_attachment" "ec2_role_policy_attachment" {
  role      = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
} */
/* resource "aws_s3_bucket_public_access_block" "wordpressdata_block" {
  bucket = aws_s3_bucket.wordpressdata.id

  block_public_acls = false
  ignore_public_acls = false
  block_public_policy = false
  restrict_public_buckets = false
} */

/* resource "aws_s3_bucket_website_configuration" "wordpresssite" {
  bucket = aws_s3_bucket.wordpressdata.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
} */

/* resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.wordpressdata.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "PublicReadGetObject",
        Effect = "Allow",
        Principal = "*",
        Action   = "s3:GetObject",
        Resource = "${aws_s3_bucket.wordpressdata.arn}/*"
      }
    ]
  })
} */