variable "aws_region" {
  description = "AWS region where the IAM policy and Terraform state bucket are located"
  type        = string
}

variable "policy_name" {
  description = "Name of the existing IAM policy to import"
  type        = string
}

variable "policy_description" {
  description = "Description of the existing IAM policy to import"
  type        = string
}
