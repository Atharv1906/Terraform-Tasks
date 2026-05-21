aws_region = "eu-west-1"

vpc_name = "cmtr-f8mezz9s-01-vpc"
vpc_cidr = "10.10.0.0/16"

subnet_public_a = {
  name = "cmtr-f8mezz9s-01-subnet-public-a"
  cidr = "10.10.1.0/24"
  az   = "eu-west-1a"
}

subnet_public_b = {
  name = "cmtr-f8mezz9s-01-subnet-public-b"
  cidr = "10.10.3.0/24"
  az   = "eu-west-1b"
}

subnet_public_c = {
  name = "cmtr-f8mezz9s-01-subnet-public-c"
  cidr = "10.10.5.0/24"
  az   = "eu-west-1c"
}

igw_name         = "cmtr-f8mezz9s-01-igw"
route_table_name = "cmtr-f8mezz9s-01-rt"
