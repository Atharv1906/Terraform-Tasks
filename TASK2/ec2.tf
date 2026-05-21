data "aws_vpc" "lab" {
  filter {
    name   = "tag:Name"
    values = [local.names.vpc]
  }
}

data "aws_security_group" "lab" {
  filter {
    name   = "group-name"
    values = [local.names.security_group]
  }

  vpc_id = data.aws_vpc.lab.id
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.lab.id]
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }
}

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "lab" {
  ami                         = data.aws_ami.al2023.id
  instance_type               = var.instance_type
  subnet_id                   = tolist(data.aws_subnets.public.ids)[0]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.this.key_name
  vpc_security_group_ids      = [data.aws_security_group.lab.id]

  tags = merge(
    local.common_tags,
    {
      Name = local.names.instance
    }
  )
}