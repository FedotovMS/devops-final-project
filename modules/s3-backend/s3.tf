resource "aws_s3_bucket" "tf_state" {
  bucket = "${var.project_name}-${var.environment}-tf-state"

  tags = {
    Name        = "${var.project_name}-tf-state"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}