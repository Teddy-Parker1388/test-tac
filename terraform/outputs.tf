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

// TODO: DELETE ME
// output "autoscaling_group_name" {
//   description = "The autoscaling group name"
//   value       = module.autoscaling_group.autoscaling_group_name
// }

output "region" {
  value = var.region
}

output "vpc" {
  value = var.vpc_id
}

output "ssh_private_key_pem" {
  value = tls_private_key.ssh_key.private_key_pem
}

// TODO: ADD ME
// output "instanceTags" {
//   value = "TODO.TAGS"
// }

// TODO: ?????
// output "alb_target_groups" {
//   description = "ALB Target Group ARN"
//   value       = [module.app_lb_private.target_group_arns[1], module.app_lb_public.target_group_arns[0]]
// }

// TODO: ????
// output "stage_target_group" {
//   description = "Staging Target Group ARN"
//   value       = module.app_lb_private.target_group_arns[0]
// }
