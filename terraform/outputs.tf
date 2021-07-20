
output "alb_dns_name_public" {
  description = "The DNS name of the public load balancer."
  value       = module.app_lb_public.this_lb_dns_name
}

output "alb_dns_name_private" {
  description = "The DNS name of the private load balancer."
  value       = module.app_lb_private.this_lb_dns_name
}

output "private_alb_tg_arn" {
  value = module.app_lb_private.target_group_arns[0]
}

output "public_alb_tg_arn" {
  value = module.app_lb_public.target_group_arns[0]
}

output "region" {
  value = var.region
}

output "vpc" {
  value = var.vpc_id
}

output "ssh_private_key_pem" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

output "instance_ips" {
  value = aws_instance.app_instance.*.private_ip
}

output "instance_tags2" {
  value = aws_instance.app_instance[0].tags
}

output "instance_tags" {
  value = {
    Product     = var.app_product
    App         = var.app_name
    Environment = var.app_env
  }
}
