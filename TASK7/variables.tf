variable "aws_region" {
  description = "AWS region for resources and remote state access"
  type        = string
}

variable "project_id" {
  description = "Project identifier used for resource tagging"
  type        = string
}

variable "state_bucket" {
  description = "S3 bucket name containing the Landing Zone Terraform state"
  type        = string
}

variable "state_key" {
  description = "S3 object key path for the Landing Zone Terraform state file"
  type        = string
}