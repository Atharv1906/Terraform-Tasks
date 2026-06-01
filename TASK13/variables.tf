variable "aws_region" {
  description = "AWS region where the blue-green deployment resources are created"
  type        = string
}

variable "project_id" {
  description = "Project identifier used for naming and tagging resources"
  type        = string
}

variable "vpc_name" {
  description = "Name tag of the existing VPC"
  type        = string
}

variable "public_subnet1_name" {
  description = "Name tag of the first existing public subnet"
  type        = string
}

variable "public_subnet2_name" {
  description = "Name tag of the second existing public subnet"
  type        = string
}

variable "ssh_security_group_name" {
  description = "Name of the existing security group that allows SSH access"
  type        = string
}

variable "http_security_group_name" {
  description = "Name of the existing security group that allows HTTP access to EC2 instances"
  type        = string
}

variable "load_balancer_security_group_name" {
  description = "Name of the existing security group that allows HTTP access to the load balancer"
  type        = string
}

variable "load_balancer_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "blue_target_group_name" {
  description = "Name of the blue target group"
  type        = string
}

variable "green_target_group_name" {
  description = "Name of the green target group"
  type        = string
}

variable "blue_launch_template_name" {
  description = "Name of the blue launch template"
  type        = string
}

variable "green_launch_template_name" {
  description = "Name of the green launch template"
  type        = string
}

variable "blue_autoscaling_group_name" {
  description = "Name of the blue Auto Scaling group"
  type        = string
}

variable "green_autoscaling_group_name" {
  description = "Name of the green Auto Scaling group"
  type        = string
}

variable "instance_type" {
  description = "Instance type used by both blue and green launch templates"
  type        = string
}

variable "blue_weight" {
  description = "Traffic weight sent to the blue target group"
  type        = number
}

variable "green_weight" {
  description = "Traffic weight sent to the green target group"
  type        = number
}

variable "desired_capacity" {
  description = "Desired instance count for each Auto Scaling group"
  type        = number
}

variable "min_size" {
  description = "Minimum instance count for each Auto Scaling group"
  type        = number
}

variable "max_size" {
  description = "Maximum instance count for each Auto Scaling group"
  type        = number
}
