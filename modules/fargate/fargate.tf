################################################################################
# ECS FARGATE 
################################################################################

locals {
  name      = "fargate-${var.environment}"
  service_1 = "webserver-${var.webserver_version_1}"
  service_2 = "webserver-${var.webserver_version_2}"
}

module "ecs_fargate" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.0.1"

  cluster_name = local.name
  tags         = var.tags

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/aws-ec2"
      }
    }
  }

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = var.provision_ondemand
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = var.provision_spot
      }
    }
  }
  services = {
    service_1 = {
      cpu                      = var.container_cpu_1
      memory                   = var.container_memory_1
      desired_count            = var.desired_min_1
      autoscaling_min_capacity = var.desired_min_1
      autoscaling_max_capacity = var.desired_max_1

      container_definitions = {
        (local.service_1) = {
          cpu       = 512
          memory    = 1024
          essential = true
          image     = "${var.docker_image}:${var.webserver_version_1}"
          port_mappings = [
            {
              name          = local.service_1
              containerPort = var.container_port
              hostPort      = var.container_port
              protocol      = "tcp"
            }
          ]
          readonly_root_filesystem = false
          memory_reservation       = 100
          #command to print the ip of the container as there is no logical enumeration, and then running nginx foreground
          command = ["sh", "-c", "echo 'Hello from web-server:${var.webserver_version_1}' > /usr/share/nginx/html/index.html && curl $ECS_CONTAINER_METADATA_URI_V4 > /usr/share/nginx/html/data.json && grep -o '\"IPv4Addresses\":\\[\\\"[^\\\"]*\\\"' /usr/share/nginx/html/data.json | sed 's/\"IPv4Addresses\":\\[\\\"\\([0-9.]*\\).*$/\\1/' >> /usr/share/nginx/html/index.html && mkdir /usr/share/nginx/html/health/ && echo 'web-server-${var.webserver_version_1}' > /usr/share/nginx/html/health/index.html && grep -o '\"IPv4Addresses\":\\[\\\"[^\\\"]*\\\"' /usr/share/nginx/html/data.json | sed 's/\"IPv4Addresses\":\\[\\\"\\([0-9.]*\\).*$/\\1/' >> /usr/share/nginx/html/health/index.html && nginx -g 'daemon off;'"]
        }
      }
      load_balancer = {
        service = {
          target_group_arn = element(module.alb.target_group_arns, 0)
          container_name   = local.service_1
          container_port   = var.container_port
        }
      }
      subnet_ids = module.vpc.private_subnets
      security_group_rules = {
        alb_ingress_3000 = {
          type                     = "ingress"
          from_port                = var.container_port
          to_port                  = var.container_port
          protocol                 = "tcp"
          description              = "Service port"
          source_security_group_id = module.alb_sg.security_group_id
        }
        egress_all = {
          type        = "egress"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
    service_2 = {
      cpu                      = var.container_cpu_2
      memory                   = var.container_memory_2
      desired_count            = var.desired_min_2
      autoscaling_min_capacity = var.desired_min_2
      autoscaling_max_capacity = var.desired_max_2

      container_definitions = {
        (local.service_2) = {
          cpu       = 512
          memory    = 1024
          essential = true
          image     = "${var.docker_image}:${var.webserver_version_2}"
          port_mappings = [
            {
              name          = local.service_2
              containerPort = var.container_port
              hostPort      = var.container_port
              protocol      = "tcp"
            }
          ]
          readonly_root_filesystem = false
          memory_reservation       = 100
          #command to print the ip of the container as there is no logical enumeration, and then running nginx foreground
          command = ["sh", "-c", "echo 'Hello from web-server:${var.webserver_version_2}' > /usr/share/nginx/html/index.html && curl $ECS_CONTAINER_METADATA_URI_V4 > /usr/share/nginx/html/data.json && grep -o '\"IPv4Addresses\":\\[\\\"[^\\\"]*\\\"' /usr/share/nginx/html/data.json | sed 's/\"IPv4Addresses\":\\[\\\"\\([0-9.]*\\).*$/\\1/' >> /usr/share/nginx/html/index.html && mkdir /usr/share/nginx/html/health/ && echo 'web-server-${var.webserver_version_2}' > /usr/share/nginx/html/health/index.html && grep -o '\"IPv4Addresses\":\\[\\\"[^\\\"]*\\\"' /usr/share/nginx/html/data.json | sed 's/\"IPv4Addresses\":\\[\\\"\\([0-9.]*\\).*$/\\1/' >> /usr/share/nginx/html/health/index.html && nginx -g 'daemon off;'"]
        }
      }
      load_balancer = {
        service = {
          target_group_arn = element(module.alb.target_group_arns, 1)
          container_name   = local.service_2
          container_port   = var.container_port
        }
      }
      subnet_ids = module.vpc.private_subnets
      security_group_rules = {
        alb_ingress_3000 = {
          type                     = "ingress"
          from_port                = var.container_port
          to_port                  = var.container_port
          protocol                 = "tcp"
          description              = "Service port"
          source_security_group_id = module.alb_sg.security_group_id
        }
        egress_all = {
          type        = "egress"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
  }
}

################################################################################
# Supporting Resources
################################################################################

module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${local.name}-service"
  description = "Service security group"
  vpc_id      = module.vpc.vpc_id

  ingress_rules       = ["http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = module.vpc.private_subnets_cidr_blocks

  tags = var.tags
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.6"

  name = local.name

  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  security_groups    = [module.alb_sg.security_group_id]

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "forward"
      forward = {
        target_groups = [
          {
            target_group_index = 0
            weight             = var.weight_1
          },
          {
            target_group_index = 1
            weight             = var.weight_2
          }
        ]
        stickiness = {
          enabled  = false
          duration = 1
        }
      }
    },
  ]

  target_groups = [
    {
      name             = "${local.name}-web-server-1"
      backend_protocol = "HTTP"
      backend_port     = var.container_port
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
    },
    {
      name             = "${local.name}-web-server-2"
      backend_protocol = "HTTP"
      backend_port     = var.container_port
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
    }
  ]

  tags = var.tags
}
