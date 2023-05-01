# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    provider "aws" {
      region = "${local.region}"
      # Only these AWS Account IDs may be operated on by this template
      allowed_account_ids = ["${local.account_id}"]
    }
  EOF
}
# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket  = "terraform-${local.account_id}-${local.env}-${local.region}"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = local.region
    #dynamodb_table = "${local.environment}-remote-state-table"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------
# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
locals {
  env_vars    = yamldecode(file(find_in_parent_folders("env.yaml")))
  environment = local.env_vars.environment
  env         = local.env_vars.env
  account_id  = local.env_vars.account_id
  region      = local.env_vars.region
}
inputs = {
  tags = {
    environment = local.environment
    terraform   = "true"
    bucket      = "terraform-${local.account_id}-${local.env}-${local.region}"
    key         = "${path_relative_to_include()}/terraform.tfstate"
  }
  environment = local.environment
  account_id  = local.account_id
  region      = local.region
}
