variable "aws_region" {
  description = "AWS region where the existing infrastructure is deployed"
  type        = string
}

variable "project_id" {
  description = "Project identifier used for naming and tagging resources"
  type        = string
}

variable "allowed_ip_range" {
  description = "List of CIDR blocks allowed to access the public-facing security groups"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the existing VPC where security groups are created"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the existing public subnet in the lab environment"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the existing private subnet in the lab environment"
  type        = string
}

variable "public_instance_id" {
  description = "ID of the existing public EC2 instance that serves HTTP on port 80"
  type        = string
}

variable "private_instance_id" {
  description = "ID of the existing private EC2 instance that serves HTTP on port 8080"
  type        = string
}