terraform {
  required_version = ">= 0.14.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.65"
    }
  }
}
