locals {
  ssh_security_group_name          = "${var.project_id}-ssh-sg"
  public_http_security_group_name  = "${var.project_id}-public-http-sg"
  private_http_security_group_name = "${var.project_id}-private-http-sg"

  common_tags = {
    Project = var.project_id
  }
}

data "aws_network_interface" "public_primary" {
  filter {
    name   = "attachment.instance-id"
    values = [var.public_instance_id]
  }

  filter {
    name   = "attachment.device-index"
    values = ["0"]
  }
}

data "aws_network_interface" "private_primary" {
  filter {
    name   = "attachment.instance-id"
    values = [var.private_instance_id]
  }

  filter {
    name   = "attachment.device-index"
    values = ["0"]
  }
}

resource "aws_security_group" "ssh" {
  name        = local.ssh_security_group_name
  description = "Allows SSH and ICMP access from approved CIDR ranges"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

resource "aws_security_group" "public_http" {
  name        = local.public_http_security_group_name
  description = "Allows public HTTP and ICMP access from approved CIDR ranges"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

resource "aws_security_group" "private_http" {
  name        = local.private_http_security_group_name
  description = "Allows HTTP and ICMP only from the public HTTP security group"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

resource "aws_security_group_rule" "ssh_ingress" {
  type              = "ingress"
  description       = "Allow SSH from approved CIDR ranges"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.ssh.id
}

resource "aws_security_group_rule" "ssh_icmp_ingress" {
  type              = "ingress"
  description       = "Allow ICMP from approved CIDR ranges"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.ssh.id
}

resource "aws_security_group_rule" "public_http_ingress" {
  type              = "ingress"
  description       = "Allow HTTP from approved CIDR ranges"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.public_http.id
}

resource "aws_security_group_rule" "public_http_icmp_ingress" {
  type              = "ingress"
  description       = "Allow ICMP from approved CIDR ranges"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.public_http.id
}

resource "aws_security_group_rule" "private_http_ingress" {
  type                     = "ingress"
  description              = "Allow private HTTP only from the public HTTP security group"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.public_http.id
  security_group_id        = aws_security_group.private_http.id
}

resource "aws_security_group_rule" "private_http_icmp_ingress" {
  type                     = "ingress"
  description              = "Allow ICMP only from the public HTTP security group"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  source_security_group_id = aws_security_group.public_http.id
  security_group_id        = aws_security_group.private_http.id
}

resource "aws_network_interface_sg_attachment" "public_instance_ssh" {
  security_group_id    = aws_security_group.ssh.id
  network_interface_id = data.aws_network_interface.public_primary.id
}

resource "aws_network_interface_sg_attachment" "public_instance_http" {
  security_group_id    = aws_security_group.public_http.id
  network_interface_id = data.aws_network_interface.public_primary.id
}

resource "aws_network_interface_sg_attachment" "private_instance_ssh" {
  security_group_id    = aws_security_group.ssh.id
  network_interface_id = data.aws_network_interface.private_primary.id
}

resource "aws_network_interface_sg_attachment" "private_instance_http" {
  security_group_id    = aws_security_group.private_http.id
  network_interface_id = data.aws_network_interface.private_primary.id
}