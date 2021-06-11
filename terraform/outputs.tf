
// output "alb_dns_name_public" {
//   description = "The DNS name of the load balancer."
//   value       = module.app_lb_public.this_lb_dns_name
// }

output "alb_dns_name_private" {
  description = "The DNS name of the load balancer."
  value       = module.app_lb_private.this_lb_dns_name
}

output "region" {
  value = var.region
}

output "vpc" {
  value = var.vpc_id
}

output "ssh_private_key_pem" {
  value = tls_private_key.ssh_key.private_key_pem
}

output "instance_tags" {
  value = {
    Product     = var.app_product
    App         = var.app_name
    Environment = var.app_env
  }
}
