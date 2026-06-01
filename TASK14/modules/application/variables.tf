variable "project_id" {
  description = "Project identifier used for naming and tagging"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where application resources are deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of public subnet IDs for the ASG and ALB"
  type        = list(string)
}

variable "ssh_sg_id" {
  description = "ID of the SSH security group for EC2 instances"
  type        = string
}

variable "private_http_sg_id" {
  description = "ID of the private HTTP security group for EC2 instances"
  type        = string
}

variable "public_http_sg_id" {
  description = "ID of the public HTTP security group for the load balancer"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
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
