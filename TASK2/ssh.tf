locals {
  project = "epam-tf-lab"
  lab_id  = "cmtr-f8mezz9s"

  names = {
    vpc            = "${local.lab_id}-vpc"
    security_group = "${local.lab_id}-sg"
    key_pair       = "${local.lab_id}-keypair"
    instance       = "${local.lab_id}-ec2"
  }

  common_tags = {
    Project = local.project
    ID      = local.lab_id
  }
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = local.names.key_pair
  public_key = tls_private_key.this.public_key_openssh

  tags = local.common_tags
}