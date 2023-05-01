################################################################################
# VPC 
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0.1"

  name = var.name
  cidr = var.cidr

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = [var.subnet_public_a, var.subnet_public_b, var.subnet_public_c]
  private_subnets = [var.subnet_private_a, var.subnet_private_b, var.subnet_private_c]

  enable_dns_hostnames               = true
  enable_dns_support                 = true
  enable_nat_gateway                 = true
  single_nat_gateway                 = true
  one_nat_gateway_per_az             = true
  create_database_subnet_group       = true
  create_database_subnet_route_table = true

  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false

  tags = var.tags
}

module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "~> 4.0.1"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [aws_security_group.vpc_endpoints.id]

  endpoints = {
    s3 = {
      service = "s3"
      tags    = var.tags
    },
    ssm = {
      service             = "ssm"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = var.tags
    },
    ssmmessages = {
      service             = "ssmmessages"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = var.tags
    },
    ec2 = {
      service             = "ec2"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
    },
    ec2messages = {
      service             = "ec2messages"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
    },
    lambda = {
      service             = "lambda"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = var.tags
    },
    kms = {
      service             = "kms"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = var.tags
    }
  }

  tags = var.tags
}

resource "aws_security_group" "vpc_endpoints" {
  name        = "vpc_endpoints"
  description = "endpoints traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.tags
}

data "aws_iam_policy_document" "generic_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:SourceVpc"

      values = [module.vpc.vpc_id]
    }
  }
}
