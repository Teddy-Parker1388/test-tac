
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

output "test_alb_tg_arn" {
  value = module.app_lb_private.target_group_arns[1]
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
  value = join("\n", aws_instance.app_instance.*.private_ip)
}

output "inventory" {
  value = join(
    "\n",
    formatlist(
      "%s tsunami_node_id=%s aws_instance_id=%s",
      aws_instance.app_instance.*.private_ip,
      aws_instance.app_instance.*.tags.TsunamiNodeId,
      aws_instance.app_instance.*.id
    )
  )
}
