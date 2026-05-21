variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string


}
variable "instance_type" {
  description = "The type of EC2 instance to use"
  type        = string
}
variable "ssh_key_name" {
  description = "The name of the SSH key pair to use for EC2 instances"
  type        = string
  sensitive   = true

}

variable "ssh_key" {
  description = "The public SSH key material to use for the key pair"
  type        = string
  sensitive   = true
}