variable "aws_region" {
  description = "AWS region where the network stack will be created"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_public_a" {
  description = "Public subnet A configuration"
  type = object({
    name = string
    cidr = string
    az   = string
  })
}

variable "subnet_public_b" {
  description = "Public subnet B configuration"
  type = object({
    name = string
    cidr = string
    az   = string
  })
}

variable "subnet_public_c" {
  description = "Public subnet C configuration"
  type = object({
    name = string
    cidr = string
    az   = string
  })
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

variable "route_table_name" {
  description = "Name of the route table"
  type        = string
}
