locals {
  common_tags = {
    Project   = var.project_id
    Terraform = "true"
  }

  ssh_sg_name          = "${var.project_id}-ssh-sg"
  public_http_sg_name  = "${var.project_id}-public-http-sg"
  private_http_sg_name = "${var.project_id}-private-http-sg"
}

resource "aws_security_group" "ssh" {
  name        = local.ssh_sg_name
  description = "Allows SSH access from approved CIDR ranges"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = local.ssh_sg_name })
}

resource "aws_security_group_rule" "ssh_ingress" {
  type              = "ingress"
  description       = "SSH from approved CIDRs"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.ssh.id
}

resource "aws_security_group" "public_http" {
  name        = local.public_http_sg_name
  description = "Allows HTTP access from approved CIDR ranges"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = local.public_http_sg_name })
}

resource "aws_security_group_rule" "public_http_ingress" {
  type              = "ingress"
  description       = "HTTP from approved CIDRs"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.public_http.id
}

resource "aws_security_group" "private_http" {
  name        = local.private_http_sg_name
  description = "Allows HTTP only from the public HTTP security group"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = local.private_http_sg_name })
}

resource "aws_security_group_rule" "private_http_ingress" {
  type                     = "ingress"
  description              = "HTTP only from public HTTP security group"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.public_http.id
  security_group_id        = aws_security_group.private_http.id
}
