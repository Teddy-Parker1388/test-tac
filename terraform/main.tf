// -----------------------------------------------------------------------------
// See Also: shared-main.tf
// -----------------------------------------------------------------------------
locals {
  private_tier_ids = [for id in data.aws_subnets.private.ids : id]
}

data "aws_acm_certificate" "cengage_info" {
  domain      = "*.cengage.info"
  most_recent = true
}

data "aws_subnets" "private" {
  filter {
    name = "vpc-id"
    values = [
      var.vpc_id
    ]
  }
  tags = {
    Name = "*-${local.env_type}-app-tier*"
  }
}

data "aws_subnets" "public" {
  filter {
    name = "vpc-id"
    values = [
      var.vpc_id
    ]
  }
  tags = {
    Name = "*-${local.env_type}-web-tier*"
  }
}

data "aws_ami" "base_image" {
  most_recent = true
  owners = [
    "self"
  ]
  filter {
    name = "name"
    values = [
      "${local.app_id}*"
    ]
  }
  filter {
    name = "tag:Cluster"
    values = [
      var.app_cluster
    ]
  }
}

module "sec_grp_instance" {
  source                   = "git::ssh://git@stash.cengage.com:7999/tm/terraform-aws-sg-extended.git?ref=1.3.0"
  name                     = "${local.app_id}-instance"
  description              = "${local.app_id} instance security group"
  vpc_id                   = var.vpc_id
  tags                     = local.common_tags
  ingress_with_cidr_blocks = var.ingress_instance
  egress_with_cidr_blocks  = var.egress_all
}

module "sec_grp_alb_public" {
  source                   = "git::ssh://git@stash.cengage.com:7999/tm/terraform-aws-sg-extended.git?ref=1.3.0"
  name                     = "${local.app_id}-alb-pub"
  description              = "${local.app_id} Public ALB security group"
  vpc_id                   = var.vpc_id
  tags                     = local.common_tags
  ingress_with_cidr_blocks = var.ingress_alb_public
  egress_with_cidr_blocks  = var.egress_all
}

module "sec_grp_alb_private" {
  source                   = "git::ssh://git@stash.cengage.com:7999/tm/terraform-aws-sg-extended.git?ref=1.3.0"
  name                     = "${local.app_id}-alb-pvt"
  description              = "${local.app_id} Private ALB security group"
  vpc_id                   = var.vpc_id
  tags                     = local.common_tags
  ingress_with_cidr_blocks = var.ingress_alb_private
  egress_with_cidr_blocks  = var.egress_all
}

module "app_lb_private" {
  source             = "git::ssh://git@stash.cengage.com:7999/tm/terraform-aws-alb.git?ref=1.5.0"
  load_balancer_type = "application"
  name               = "${local.app_id}-pvt"
  internal           = true
  vpc_id             = var.vpc_id
  subnets            = data.aws_subnets.private.ids
  security_groups = [
    module.sec_grp_alb_private.this_security_group_id
  ]
  tags    = local.common_tags
  lb_tags = local.common_tags
  target_groups = [
    {
      name_prefix          = "Pvt-"
      backend_protocol     = "HTTP"
      backend_port         = var.app_port
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = var.app_healthcheck_path
        port                = var.app_healthcheck_port
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = var.app_healthcheck_protocol
        matcher             = "200"
      }
    },
    {
      name_prefix          = "Tst-"
      backend_protocol     = "HTTP"
      backend_port         = var.app_port
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = var.app_healthcheck_path
        port                = var.app_healthcheck_port
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = var.app_healthcheck_protocol
        matcher             = "200"
      }
    }
  ]
  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    },
    {
      port               = 8080
      protocol           = "HTTP"
      target_group_index = 1
    }
  ]
  https_listeners = [
    {
      port               = 443
      certificate_arn    = data.aws_acm_certificate.cengage_info.arn
      target_group_index = 0
    },
    {
      port               = 8443
      certificate_arn    = data.aws_acm_certificate.cengage_info.arn
      target_group_index = 1
    }
  ]
  target_group_tags = local.common_tags
}

module "app_lb_public" {
  source             = "git::ssh://git@stash.cengage.com:7999/tm/terraform-aws-alb.git?ref=1.5.0"
  load_balancer_type = "application"
  name               = "${local.app_id}-pub"
  internal           = false
  vpc_id             = var.vpc_id
  subnets            = data.aws_subnets.public.ids
  security_groups = [
    module.sec_grp_alb_public.this_security_group_id
  ]
  tags    = local.common_tags
  lb_tags = local.common_tags
  target_groups = [
    {
      name_prefix          = "Pub-"
      backend_protocol     = "HTTP"
      backend_port         = var.app_port
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = var.app_healthcheck_path
        port                = var.app_healthcheck_port
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = var.app_healthcheck_protocol
        matcher             = "200"
      }
    }
  ]
  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]
  https_listeners = [
    {
      port               = 443
      certificate_arn    = data.aws_acm_certificate.cengage_info.arn
      target_group_index = 0
    }
  ]
  target_group_tags = local.common_tags
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "ssh_key_pair" {
  key_name   = "${local.app_id}-key-pair"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "aws_instance" "app_instance" {
  count         = var.instance_count
  ami           = data.aws_ami.base_image.id
  instance_type = var.instance_type
  subnet_id     = element(local.private_tier_ids, count.index % length(local.private_tier_ids))
  key_name      = aws_key_pair.ssh_key_pair.key_name
  vpc_security_group_ids = [
    module.sec_grp_instance.this_security_group_id
  ]
  tags = merge(local.common_tags, { "Name" : "${local.app_id}-${count.index}", "TsunamiNodeId" : "${count.index + 1}" })
}

resource "aws_cloudwatch_metric_alarm" "reboot_on_fail" {
  count               = var.instance_count
  alarm_name          = "${local.app_id}_${count.index}_${aws_instance.app_instance[count.index].id}_reboot"
  alarm_description   = "Reboot instance on failure."
  metric_name         = "StatusCheckFailed_Instance"
  namespace           = "AWS/EC2"
  comparison_operator = "GreaterThanThreshold"
  threshold           = "0"
  statistic           = "Minimum"
  period              = "300"
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  dimensions = {
    InstanceId = aws_instance.app_instance[count.index].id
  }
  alarm_actions = [
    "arn:aws:automate:${var.region}:ec2:reboot"
  ]
}

resource "aws_lb_target_group_attachment" "register_instances_private" {
  count            = var.instance_count
  target_group_arn = module.app_lb_private.target_group_arns[0]
  target_id        = aws_instance.app_instance[count.index].id
  port             = var.app_port
}

resource "aws_lb_target_group_attachment" "register_instances_public" {
  count            = var.instance_count
  target_group_arn = module.app_lb_public.target_group_arns[0]
  target_id        = aws_instance.app_instance[count.index].id
  port             = var.app_port
}
