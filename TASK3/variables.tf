variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "bucket_name" {
  description = "Globally unique name for the S3 bucket"
  type        = string
}

variable "project_tag" {
  description = "Project tag value applied to resources"
  type        = string
}
