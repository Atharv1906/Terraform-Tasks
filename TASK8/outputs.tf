output "launch_template_id" {
  description = "ID of the created launch template"
  value       = aws_launch_template.this.id
}

output "autoscaling_group_name" {
  description = "Name of the created Auto Scaling Group"
  value       = aws_autoscaling_group.this.name
}

output "load_balancer_dns_name" {
  description = "DNS name of the created Application Load Balancer"
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "ARN of the created target group"
  value       = aws_lb_target_group.this.arn
}
