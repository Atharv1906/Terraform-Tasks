variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
}

variable "project" {
  description = "Project tag value"
  type        = string
}

variable "terraform_tag" {
  description = "Terraform tag value"
  type        = string
}

variable "vpc_name" {
  description = "Name tag of the pre-created VPC"
  type        = string
}

variable "public_subnet_a_cidr" {
  description = "CIDR block for public subnet A"
  type        = string
}

variable "public_subnet_b_cidr" {
  description = "CIDR block for public subnet B"
  type        = string
}

variable "private_subnet_a_cidr" {
  description = "CIDR block for private subnet A"
  type        = string
}

variable "private_subnet_b_cidr" {
  description = "CIDR block for private subnet B"
  type        = string
}

variable "ec2_sg_name" {
  description = "Name of the EC2 SSH security group"
  type        = string
}

variable "http_sg_name" {
  description = "Name of the EC2 HTTP security group"
  type        = string
}

variable "alb_sg_name" {
  description = "Name of the load balancer security group"
  type        = string
}

variable "instance_profile_name" {
  description = "Name of the IAM instance profile for EC2"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "launch_template_name" {
  description = "Name of the launch template"
  type        = string
}

variable "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "load_balancer_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type used by launch template"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
}
