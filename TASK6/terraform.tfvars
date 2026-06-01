aws_region       = "eu-west-1"
project_id       = "cmtr-f8mezz9s"
vpc_name         = "cmtr-f8mezz9s-01-vpc"
vpc_cidr_block   = "10.10.0.0/16"
igw_name         = "cmtr-f8mezz9s-01-igw"
route_table_name = "cmtr-f8mezz9s-01-rt"

public_subnets = {
  public_a = {
    name              = "cmtr-f8mezz9s-01-subnet-public-a"
    availability_zone = "eu-west-1a"
    cidr_block        = "10.10.1.0/24"
  }
  public_b = {
    name              = "cmtr-f8mezz9s-01-subnet-public-b"
    availability_zone = "eu-west-1b"
    cidr_block        = "10.10.3.0/24"
  }
  public_c = {
    name              = "cmtr-f8mezz9s-01-subnet-public-c"
    availability_zone = "eu-west-1c"
    cidr_block        = "10.10.5.0/24"
  }
}