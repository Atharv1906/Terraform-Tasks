variable "aws_region" {
  description = "AWS region where all resources are created"
  type        = string
}

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

variable "allowed_ip_range" {
  description = "List of CIDR blocks allowed SSH and HTTP access"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type for the launch template"
  type        = string
}

variable "launch_template_name" {
  description = "Name of the launch template"
  type        = string
}

variable "asg_name" {
  description = "Name of the Auto Scaling group"
  type        = string
}

variable "load_balancer_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "target_group_name" {
  description = "Name of the ALB target group"
  type        = string
}
