output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.network.vpc_id
}

output "subnet_ids" {
  description = "IDs of the created public subnets"
  value       = module.network.subnet_ids
}

output "load_balancer_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.application.load_balancer_dns_name
}
