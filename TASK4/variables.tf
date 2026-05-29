variable "aws_region" {
  description = "AWS region where IAM resources are managed"
  type        = string
}

variable "iam_group_name" {
  description = "Name of the IAM group"
  type        = string
}

variable "iam_policy_name" {
  description = "Name of the custom IAM policy"
  type        = string
}

variable "iam_role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "Name of the IAM instance profile"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name used in custom IAM policy"
  type        = string
}

variable "project_tag" {
  description = "Project tag value applied to all supported resources"
  type        = string
}
