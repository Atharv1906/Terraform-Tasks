variable "project_id" {
  description = "Project identifier used for naming and tagging"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where security groups are created"
  type        = string
}

variable "allowed_ip_range" {
  description = "List of CIDR blocks allowed SSH and public HTTP access"
  type        = list(string)
}
