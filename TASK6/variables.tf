variable "aws_region" {
  description = "AWS region where network resources are created"
  type        = string
}

variable "project_id" {
  description = "Project identifier used in resource tags"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block assigned to the VPC"
  type        = string
}

variable "igw_name" {
  description = "Name tag for the Internet Gateway"
  type        = string
}

variable "route_table_name" {
  description = "Name tag for the public route table"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet definitions keyed by identifier"
  type = map(object({
    name              = string
    availability_zone = string
    cidr_block        = string
  }))
}