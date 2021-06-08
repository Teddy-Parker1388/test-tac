output "security_group_id" {
  value = module.sec_grp_instance.this_security_group_id
}

output "alb_dns_name_public" {
  description = "The DNS name of the load balancer."
  value       = module.app_lb_public.this_lb_dns_name
}

output "alb_dns_name_private" {
  description = "The DNS name of the load balancer."
  value       = module.app_lb_private.this_lb_dns_name
}

output "autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.autoscaling_group.autoscaling_group_name
}

output "region" {
  value = var.region
}

output "alb_target_groups" {
  description = "ALB Target Group ARN"
  value       = [module.app_lb_private.target_group_arns[1], module.app_lb_public.target_group_arns[0]]
}

output "stage_target_group" {
  description = "Staging Target Group ARN"
  value       = module.app_lb_private.target_group_arns[0]
}
