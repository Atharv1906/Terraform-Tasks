module "network" {
  source = "./modules/network"

  project_id       = var.project_id
  vpc_cidr         = var.vpc_cidr
  subnets          = var.subnets
  igw_name         = var.igw_name
  route_table_name = var.route_table_name
}

module "network_security" {
  source = "./modules/network_security"

  project_id       = var.project_id
  vpc_id           = module.network.vpc_id
  allowed_ip_range = var.allowed_ip_range
}

module "application" {
  source = "./modules/application"

  project_id           = var.project_id
  subnet_ids           = module.network.subnet_ids
  ssh_sg_id            = module.network_security.ssh_sg_id
  private_http_sg_id   = module.network_security.private_http_sg_id
  public_http_sg_id    = module.network_security.public_http_sg_id
  instance_type        = var.instance_type
  launch_template_name = var.launch_template_name
  asg_name             = var.asg_name
  load_balancer_name   = var.load_balancer_name
  target_group_name    = var.target_group_name
  vpc_id               = module.network.vpc_id
}
