variable "name" {
  description = "VPC Name"
  type        = string
}
variable "environment" {
  description = "Environment Name"
  type        = string
}
variable "cidr" {
  description = "CIDR"
  type        = string
}
variable "subnet_public_a" {
  description = "public subnet az-a"
  type        = string
}
variable "subnet_public_b" {
  description = "public subnet az-b"
  type        = string
}
variable "subnet_public_c" {
  description = "public subnet az-c"
  type        = string
}
variable "subnet_private_a" {
  description = "private subnet az-a"
  type        = string
}
variable "subnet_private_b" {
  description = "private subnet az-b"
  type        = string
}
variable "subnet_private_c" {
  description = "private subnet az-c"
  type        = string
}
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

####################
# Cluster Variables
####################

variable "container_port" {
  description = "Container port"
  default     = 80
}

variable "service_name" {
  description = "Service name"
  default     = "web_server"
  type        = string
}

variable "docker_image" {
  description = "The Docker image to use for the container running the web server"
  default     = "public.ecr.aws/nginx/nginx"
  type        = string
}

variable "webserver_version_1" {
  description = "Webserver Version 1"
  type        = string
  default     = "stable"
}

variable "webserver_version_2" {
  description = "Webserver Version 2"
  type        = string
  default     = "latest"
}

variable "container_memory_1" {
  description = "The amount of memory to allocate to the container running the web server"
}

variable "container_cpu_1" {
  description = "The amount of CPU to allocate to the ECS tasks"
}

variable "container_memory_2" {
  description = "The amount of memory to allocate to the container running the web server"
}

variable "container_cpu_2" {
  description = "The amount of CPU to allocate to the ECS tasks"
}

variable "desired_min_1" {
  description = "The desired min number of tasks to run"
}

variable "desired_max_1" {
  description = "The desired max number of tasks to run"
}

variable "desired_min_2" {
  description = "The desired min number of tasks to run"
}

variable "desired_max_2" {
  description = "The desired max number of tasks to run"
}

variable "weight_1" {
  description = "weight for alb web-server-1"
}

variable "weight_2" {
  description = "weight for alb web-server-2"
}

variable "provision_ondemand" {
  description = "provision ondemand"
}

variable "provision_spot" {
  description = "provision spot"
}

variable "assign_public_ip" {
  description = "Assign public IP to the Fargate tasks"
  type        = bool
  default     = false
}
