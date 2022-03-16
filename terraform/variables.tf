// -----------------------------------------------------------------------------
// See Also: shared-variables.tf
// -----------------------------------------------------------------------------

// TODO: INSTANCE_TYPE: Must change value to reflect the desired EC2 size for environment.
variable "instance_type" {
  type    = string
  default = "t3.medium"
}

// TODO: INSTANCE_COUNT: Must change value to reflect the desired EC2 instance count for environment.
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
    },
    {
      rule        = "https-443-tcp"
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
      rule        = "https-443-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "http-8080-tcp"
      cidr_blocks = "10.0.0.0/8"
    },
    {
      rule        = "https-8443-tcp"
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

variable "app_healthcheck_path" {
  description = "The path to use for application health checks"
  type        = string
  default     = "/"
}

variable "app_healthcheck_protocol" {
  description = "The protocol to use for application health checks"
  type        = string
  default     = "HTTP"
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
