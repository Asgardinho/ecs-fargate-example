include {
  path = find_in_parent_folders("terragrunt.hcl")
}
terraform {
  source = "../../../modules//fargate"
}
locals {
  env_vars = yamldecode(file(find_in_parent_folders("env.yaml")))
}
inputs = {
  name = "vpc_${local.env_vars["environment"]}"

  provision_ondemand  = local.env_vars["provision_ondemand"]
  provision_spot      = local.env_vars["provision_spot"]
  docker_image        = local.env_vars["docker_image"]
  webserver_version_1 = local.env_vars["webserver_version_1"]
  container_memory_1  = local.env_vars["container_memory_1"]
  container_cpu_1     = local.env_vars["container_cpu_1"]
  desired_min_1       = local.env_vars["desired_min_1"]
  desired_max_1       = local.env_vars["desired_max_1"]

  webserver_version_2 = local.env_vars["webserver_version_2"]
  container_memory_2  = local.env_vars["container_memory_2"]
  container_cpu_2     = local.env_vars["container_cpu_2"]
  desired_min_2       = local.env_vars["desired_min_2"]
  desired_max_2       = local.env_vars["desired_max_2"]

  weight_1 = local.env_vars["weight_1"]
  weight_2 = local.env_vars["weight_2"]

  #VPC INFO
  cidr            = "10.8.0.0/16"
  subnet_public_a = "10.8.1.0/24"
  subnet_public_b = "10.8.2.0/24"
  subnet_public_c = "10.8.3.0/24"

  subnet_private_a = "10.8.51.0/24"
  subnet_private_b = "10.8.52.0/24"
  subnet_private_c = "10.8.53.0/24"

  subnet_database_a = "10.8.101.0/24"
  subnet_database_b = "10.8.102.0/24"
  subnet_database_c = "10.8.103.0/24"
}
