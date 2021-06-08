provider "aws" {
  region = var.region
}

terraform {
  required_version = "~> 0.13.0"

  required_providers {
    aws = "3.22.0"
  }

  # TODO: KEY **must** be updated to reflect environment.
  backend "s3" {
    bucket         = "cengage-shared-terraform-backend"
    key            = "901254650597/devops-non-prod/tsunami-ref-app/dev.tfstate"
    dynamodb_table = "terraform-lock"
    role_arn       = "arn:aws:iam::084140270005:role/devops-non-prod"
    region         = "us-east-1"
    encrypt        = true
  }
}

#selects the VPC for deployment
data "aws_vpc" "selected" {
  id = var.vpc_id
}

locals {
  common_tags = {
    Name        = var.app_name
    Environment = var.app_env
    Product     = var.app_product
  }
}

# Instance Security Group
module "sec_grp_instance" {
  source      = "git::ssh://git@stash.cengage.com:7999/tm/terraform-aws-sg-extended.git?ref=1.1.0"
  name        = "${var.app_name}-instance"
  description = "${var.app_name} instance security group"
  vpc_id      = data.aws_vpc.selected.id

  tags = local.common_tags

  ingress_with_cidr_blocks = var.ingress_instance
  egress_with_cidr_blocks  = var.egress_all
}

# ALB Security Group - Public
module "sec_grp_alb_public" {
  source      = "git::ssh://git@stash.cengage.com:7999/tm/terraform-aws-sg-extended.git?ref=1.1.0"
  name        = "${var.app_name}-alb-public"
  description = "${var.app_name} Public ALB security group"
  vpc_id      = data.aws_vpc.selected.id

  tags                     = local.common_tags
  ingress_with_cidr_blocks = var.ingress_alb_public
  egress_with_cidr_blocks  = var.egress_all
}

# ALB Security Group - Private
module "sec_grp_alb_private" {
  source      = "git::ssh://git@stash.cengage.com:7999/tm/terraform-aws-sg-extended.git?ref=1.1.0"
  name        = "${var.app_name}-alb-private"
  description = "${var.app_name} Private ALB security group"
  vpc_id      = data.aws_vpc.selected.id

  tags                     = local.common_tags
  ingress_with_cidr_blocks = var.ingress_alb_private
  egress_with_cidr_blocks  = var.egress_all
}

#Creates autoscaling group, launch configuration, asg policy and cloudwatch alarms with the specified AMI
module "autoscaling_group" {
  source = "git::ssh://git@stash.cengage.com:7999/tm/aws-autoscaling-from-launchtemplate.git?ref=1.1.0"

  name               = "${var.app_name}-${var.app_env}-"
  instance_type      = var.instance_type
  image_id           = var.image_id
  security_group_ids = [module.sec_grp_instance.this_security_group_id]
  subnet_ids         = var.private_subnets
  health_check_type  = "ELB"
  // Should be kept at 0 since Harness handles the ASG details on deployment
  min_size = 0
  // Should be kept at 0 since Harness handles the ASG details on deployment
  max_size                    = 0
  associate_public_ip_address = true
  target_group_arns           = [module.app_lb_private.target_group_arns[0], module.app_lb_public.target_group_arns[0]]
  health_check_grace_period   = 30
  default_cooldown            = 30

  tags = merge(local.common_tags, {
    "AddToLogicMonitor" = var.add_to_logicmonitor
  })

  ##  Autoscaling policies and Cloudwatch alarms
  autoscaling_policies = "target_tracking"
  scaling_policy_name  = "${var.app_name}-${var.app_env}-scaling-policy"
  target_tracking_scaling = [
    {
      scaling_metric = "ASGAverageCPUUtilization"
      scaling_value  = 50
    }
  ]

}

# Private ALB
module "app_lb_private" {
  source = "git::ssh://git@stash.cengage.com:7999/tm/terraform-aws-alb.git?ref=1.1.0"

  load_balancer_type = "application"
  name               = "${var.app_name}-${var.app_env}-private"
  internal           = true
  vpc_id             = data.aws_vpc.selected.id
  subnets            = var.private_subnets
  security_groups    = [module.sec_grp_alb_private.this_security_group_id]

  tags    = local.common_tags
  lb_tags = local.common_tags

  target_groups = [
    {
      name_prefix          = "Blue-"
      backend_protocol     = "HTTP"
      backend_port         = var.app_port
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = var.app_healthcheck_port
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }
    },
    {
      name_prefix          = "Green-"
      backend_protocol     = "HTTP"
      backend_port         = var.app_port
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = var.app_healthcheck_port
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }
    }
  ]

  http_tcp_listeners = [
    # Forward action is default, either when defined or undefined
    {
      port               = 8080
      protocol           = "HTTP"
      target_group_index = 0
    },
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 1
    }
  ]

  target_group_tags = local.common_tags
}

# Public ALB
module "app_lb_public" {
  source = "git::ssh://git@stash.cengage.com:7999/tm/terraform-aws-alb.git?ref=1.1.0"

  load_balancer_type = "application"
  name               = "${var.app_name}-${var.app_env}-public"
  internal           = false
  vpc_id             = data.aws_vpc.selected.id
  subnets            = var.public_subnets
  security_groups    = [module.sec_grp_alb_public.this_security_group_id]

  tags    = local.common_tags
  lb_tags = local.common_tags

  target_groups = [
    {
      name_prefix          = "Live-"
      backend_protocol     = "HTTP"
      backend_port         = var.app_port
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = var.app_healthcheck_port
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }
    }
  ]

  http_tcp_listeners = [
    # Forward action is default, either when defined or undefined
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  target_group_tags = local.common_tags
}
