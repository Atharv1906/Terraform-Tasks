variable "project_id" {
  description = "Project identifier used for naming and tagging"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnets" {
  description = "Map of public subnet definitions keyed by identifier"
  type = map(object({
    name = string
    az   = string
    cidr = string
  }))
}

variable "igw_name" {
  description = "Name for the internet gateway"
  type        = string
}

variable "route_table_name" {
  description = "Name for the public route table"
  type        = string
}
