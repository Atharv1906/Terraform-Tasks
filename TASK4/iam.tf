locals {
  common_tags = {
    Project = var.project_tag
  }
}

resource "aws_iam_group" "main" {
  name = var.iam_group_name
}

resource "aws_iam_policy" "s3_write" {
  name   = var.iam_policy_name
  policy = templatefile("${path.module}/policy.json", { bucket_name = var.s3_bucket_name })
  tags   = local.common_tags
}

resource "aws_iam_role" "ec2_role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "s3_write_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_write.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.ec2_role.name

  tags = local.common_tags
}
