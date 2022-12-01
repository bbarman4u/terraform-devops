output "alb_sg_group_id" {
  description = "The ID of the security group"
  value       = module.alb_sg.security_group_id
}

output "lb_arn" {
  description = "The ID and ARN of the load balancer we created."
  value       = aws_lb.back_end_services_alb.arn
}

output "lb_dns_name" {
  description = "The ID and ARN of the load balancer we created."
  value       = aws_lb.back_end_services_alb.dns_name
}