provider "aws" {
  region = var.aws_region
}

locals {
  common_tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  subnet_id     = data.terraform_remote_state.base_infra.outputs.public_subnet_id

  vpc_security_group_ids = [
    data.terraform_remote_state.base_infra.outputs.security_group_id
  ]

  tags = local.common_tags
}