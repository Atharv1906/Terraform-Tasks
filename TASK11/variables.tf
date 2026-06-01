variable "aws_region" {
  description = "AWS region where the IAM policy and S3 backends are located"
  type        = string
}

variable "policy_name" {
  description = "Name of the IAM policy managed by Terraform"
  type        = string
}

variable "policy_description" {
  description = "Description of the IAM policy managed by Terraform"
  type        = string
}
