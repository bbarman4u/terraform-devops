locals {
  bucket_name = "upload-bucket"
  queue_name  = "upload-queue"
  env_name    = "dev"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "upload-bucket"
  tags = {
    Name        = local.bucket_name
    Environment = local.env_name
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

resource "aws_sqs_queue" "queue" {
  name                      = "upload-queue"
  delay_seconds             = 60
  max_message_size          = 8192
  message_retention_seconds = 172800
  receive_wait_time_seconds = 15
  policy                    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "1",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws:sqs:*:*:s3-event-queue",
      "Condition": {
        "ArnEquals": { "aws:SourceArn": "${aws_s3_bucket.bucket.arn}" }
      }
    }
  ]
}
EOF
  tags = {
    Environment = local.env_name
  }
}

# Send notification to upload-queue when object created in s3 bucket
resource "aws_s3_bucket_notification" "bucket_notif" {
  bucket = aws_s3_bucket.bucket.id

  queue {
    queue_arn = aws_sqs_queue.queue.arn
    events    = ["s3:ObjectCreated:*"]
  }
}