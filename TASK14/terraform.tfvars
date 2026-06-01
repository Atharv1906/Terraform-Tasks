aws_region = "eu-west-1"
project_id = "cmtr-f8mezz9s"
vpc_cidr   = "10.10.0.0/16"

subnets = {
  public_a = {
    name = "cmtr-f8mezz9s-subnet-public-a"
    az   = "eu-west-1a"
    cidr = "10.10.1.0/24"
  }
  public_b = {
    name = "cmtr-f8mezz9s-subnet-public-b"
    az   = "eu-west-1b"
    cidr = "10.10.3.0/24"
  }
  public_c = {
    name = "cmtr-f8mezz9s-subnet-public-c"
    az   = "eu-west-1c"
    cidr = "10.10.5.0/24"
  }
}

igw_name         = "cmtr-f8mezz9s-igw"
route_table_name = "cmtr-f8mezz9s-rt"

allowed_ip_range = ["18.153.146.156/32", "203.170.48.2/32"]

instance_type        = "t3.micro"
launch_template_name = "cmtr-f8mezz9s-template"
asg_name             = "cmtr-f8mezz9s-asg"
load_balancer_name   = "cmtr-f8mezz9s-lb"
target_group_name    = "cmtr-f8mezz9s-tg"
