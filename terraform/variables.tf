variable "region" {
  default = "us-east-1"
}

variable "app_name" {
  description = "Application Name"
  type        = string
  default     = "mostly-harmless"
}

variable "app_env" {
  description = "Application Deployment Environment"
  type        = string
}

variable "app_product" {
  description = "Application Product Group"
  type        = string
  default     = "DevOps"
}

// -----------------------------------------------------------------------------
// ENVIRONMENT SPECIFIC CHANGES REQUIRED BELOW
// -----------------------------------------------------------------------------
// TODO: VPC_ID: Must change value to reflect VPC for environment.
variable "vpc_id" {
  default     = "vpc-05888f065bca4b7d1"
  description = "The deployment VPC on AWS."
}

// TODO: SUBNETS: Must change values to reflect the above VPC's *APP* tier subnets.
variable "private_subnets" {
  description = "A list of subnets to associate with the load balancer."
  type        = list(string)
  default = [
    "subnet-0102fdf161708d416",
    "subnet-003af1f817850673f",
    "subnet-01cf90f812f91a056",
    "subnet-025da1decd534cdab"
  ]
}

// TODO: SUBNETS: Must change values to reflect the above VPC's *WEB* tier subnets.
variable "public_subnets" {
  description = "A list of subnets to associate with the load balancer."
  type        = list(string)
  default = [
    "subnet-04728a2924ff7865e",
    "subnet-08fcfdc02dd1609a0",
    "subnet-0a19dd1695495413a",
    "subnet-0182390929796ef9a"
  ]
}

// TODO: INSTANCE_TYPE: Must change value to reflect the desired EC2 size for environment.
variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "instance_count" {
  type    = number
  default = 4
}
// -----------------------------------------------------------------------------

variable "add_to_logicmonitor" {
  type        = string
  default     = "false"
  description = "Controls an instance Tag named AddToLogicMonitor. When 'true' and the ASG-to-LM bridge is properly configured, new instance will be added to LogicMonitor on ASG scale-up events."
}

variable "ingress_alb_public" {
  description = "Public ALB Ingress"
  type        = list(map(string))
  default = [
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

variable "ingress_alb_private" {
  description = "Private ALB Ingress"
  type        = list(map(string))
  default = [
    {
      rule        = "http-80-tcp"
      cidr_blocks = "10.0.0.0/8"
    },
    {
      rule        = "http-8080-tcp"
      cidr_blocks = "10.0.0.0/8"
    }
  ]
}

variable "app_port" {
  description = "The port on which the application listens"
  type        = number
  default     = 8080
}

variable "app_healthcheck_port" {
  description = "The port to use for application health checks"
  type        = number
  default     = 8080
}

variable "ingress_instance" {
  description = "Instance Ingress"
  type        = list(map(string))
  default = [
    {
      rule        = "http-8080-tcp",
      cidr_blocks = "10.0.0.0/8"
    },
    {
      rule        = "ssh-tcp"
      cidr_blocks = "10.0.0.0/8"
    },
    {
      rule        = "ntp-udp"
      cidr_blocks = "10.0.0.0/8"
    },
    {
      rule        = "all-icmp"
      cidr_blocks = "10.0.0.0/8"
    }
  ]
}

variable "egress_all" {
  description = "General Egress (ALL)"
  type        = list(map(string))
  default = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
