locals {
  common_tags = {
    Project   = var.project_id
    Terraform = "true"
  }

  blue_user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y httpd
    systemctl enable httpd
    systemctl start httpd
    cat <<HTML > /var/www/html/index.html
    <!doctype html>
    <html>
      <head><title>Blue Environment</title></head>
      <body><h1>Blue Environment</h1></body>
    </html>
    HTML
    EOF

  green_user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y httpd
    systemctl enable httpd
    systemctl start httpd
    cat <<HTML > /var/www/html/index.html
    <!doctype html>
    <html>
      <head><title>Green Environment</title></head>
      <body><h1>Green Environment</h1></body>
    </html>
    HTML
    EOF
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "public_1" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet1_name]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

data "aws_subnet" "public_2" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet2_name]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

data "aws_security_group" "ssh" {
  filter {
    name   = "group-name"
    values = [var.ssh_security_group_name]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

data "aws_security_group" "http" {
  filter {
    name   = "group-name"
    values = [var.http_security_group_name]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

data "aws_security_group" "lb" {
  filter {
    name   = "group-name"
    values = [var.load_balancer_security_group_name]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

data "aws_ami" "amazon_linux_2023" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_launch_template" "blue" {
  name          = var.blue_launch_template_name
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups = [
      data.aws_security_group.ssh.id,
      data.aws_security_group.http.id
    ]
  }

  user_data = base64encode(local.blue_user_data)

  tag_specifications {
    resource_type = "instance"
    tags = merge(local.common_tags, {
      Name        = var.blue_launch_template_name
      Environment = "blue"
    })
  }

  tag_specifications {
    resource_type = "volume"
    tags = merge(local.common_tags, {
      Environment = "blue"
    })
  }

  tags = merge(local.common_tags, {
    Name        = var.blue_launch_template_name
    Environment = "blue"
  })
}

resource "aws_launch_template" "green" {
  name          = var.green_launch_template_name
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups = [
      data.aws_security_group.ssh.id,
      data.aws_security_group.http.id
    ]
  }

  user_data = base64encode(local.green_user_data)

  tag_specifications {
    resource_type = "instance"
    tags = merge(local.common_tags, {
      Name        = var.green_launch_template_name
      Environment = "green"
    })
  }

  tag_specifications {
    resource_type = "volume"
    tags = merge(local.common_tags, {
      Environment = "green"
    })
  }

  tags = merge(local.common_tags, {
    Name        = var.green_launch_template_name
    Environment = "green"
  })
}

resource "aws_lb" "this" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.lb.id]
  subnets = [
    data.aws_subnet.public_1.id,
    data.aws_subnet.public_2.id
  ]

  tags = local.common_tags
}

resource "aws_lb_target_group" "blue" {
  name     = var.blue_target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.selected.id

  health_check {
    path                = "/"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = merge(local.common_tags, {
    Environment = "blue"
  })
}

resource "aws_lb_target_group" "green" {
  name     = var.green_target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.selected.id

  health_check {
    path                = "/"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = merge(local.common_tags, {
    Environment = "green"
  })
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = var.blue_weight
      }

      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = var.green_weight
      }
    }
  }

  tags = local.common_tags
}

resource "aws_autoscaling_group" "blue" {
  name             = var.blue_autoscaling_group_name
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = [
    data.aws_subnet.public_1.id,
    data.aws_subnet.public_2.id
  ]

  launch_template {
    id      = aws_launch_template.blue.id
    version = "$Latest"
  }

  tag {
    key                 = "Project"
    value               = var.project_id
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "blue"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "green" {
  name             = var.green_autoscaling_group_name
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = [
    data.aws_subnet.public_1.id,
    data.aws_subnet.public_2.id
  ]

  launch_template {
    id      = aws_launch_template.green.id
    version = "$Latest"
  }

  tag {
    key                 = "Project"
    value               = var.project_id
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "green"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "blue" {
  autoscaling_group_name = aws_autoscaling_group.blue.id
  lb_target_group_arn    = aws_lb_target_group.blue.arn
}

resource "aws_autoscaling_attachment" "green" {
  autoscaling_group_name = aws_autoscaling_group.green.id
  lb_target_group_arn    = aws_lb_target_group.green.arn
}
