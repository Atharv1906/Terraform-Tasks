locals {
  instance_name = "${var.project_id}-instance"

  common_tags = {
    Name      = local.instance_name
    Project   = var.project_id
    Terraform = "true"
  }
}

resource "aws_instance" "main" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = "t3.micro"
  subnet_id              = data.aws_subnet.public.id
  vpc_security_group_ids = [data.aws_security_group.instance.id]

  tags = local.common_tags
}
