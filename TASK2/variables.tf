variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to use"
  type        = string
}

variable "ssh_key" {
  description = "Provides custom public SSH key."
  type        = string
  sensitive   = true
}