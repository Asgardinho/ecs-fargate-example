# vpc

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0, < 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.65 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.65 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | ~> 8.6 |
| <a name="module_alb_sg"></a> [alb\_sg](#module\_alb\_sg) | terraform-aws-modules/security-group/aws | ~> 4.0 |
| <a name="module_ecs_fargate"></a> [ecs\_fargate](#module\_ecs\_fargate) | terraform-aws-modules/ecs/aws | ~> 5.0.1 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 4.0.1 |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | terraform-aws-modules/vpc/aws//modules/vpc-endpoints | ~> 4.0.1 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.vpc_endpoints](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_iam_policy_document.generic_endpoint_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Assign public IP to the Fargate tasks | `bool` | `false` | no |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | CIDR | `string` | n/a | yes |
| <a name="input_container_cpu_1"></a> [container\_cpu\_1](#input\_container\_cpu\_1) | The amount of CPU to allocate to the ECS tasks | `any` | n/a | yes |
| <a name="input_container_cpu_2"></a> [container\_cpu\_2](#input\_container\_cpu\_2) | The amount of CPU to allocate to the ECS tasks | `any` | n/a | yes |
| <a name="input_container_memory_1"></a> [container\_memory\_1](#input\_container\_memory\_1) | The amount of memory to allocate to the container running the web server | `any` | n/a | yes |
| <a name="input_container_memory_2"></a> [container\_memory\_2](#input\_container\_memory\_2) | The amount of memory to allocate to the container running the web server | `any` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Container port | `number` | `80` | no |
| <a name="input_desired_max_1"></a> [desired\_max\_1](#input\_desired\_max\_1) | The desired max number of tasks to run | `any` | n/a | yes |
| <a name="input_desired_max_2"></a> [desired\_max\_2](#input\_desired\_max\_2) | The desired max number of tasks to run | `any` | n/a | yes |
| <a name="input_desired_min_1"></a> [desired\_min\_1](#input\_desired\_min\_1) | The desired min number of tasks to run | `any` | n/a | yes |
| <a name="input_desired_min_2"></a> [desired\_min\_2](#input\_desired\_min\_2) | The desired min number of tasks to run | `any` | n/a | yes |
| <a name="input_docker_image"></a> [docker\_image](#input\_docker\_image) | The Docker image to use for the container running the web server | `string` | `"public.ecr.aws/nginx/nginx"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment Name | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | VPC Name | `string` | n/a | yes |
| <a name="input_provision_ondemand"></a> [provision\_ondemand](#input\_provision\_ondemand) | provision ondemand | `any` | n/a | yes |
| <a name="input_provision_spot"></a> [provision\_spot](#input\_provision\_spot) | provision spot | `any` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Service name | `string` | `"web_server"` | no |
| <a name="input_subnet_private_a"></a> [subnet\_private\_a](#input\_subnet\_private\_a) | private subnet az-a | `string` | n/a | yes |
| <a name="input_subnet_private_b"></a> [subnet\_private\_b](#input\_subnet\_private\_b) | private subnet az-b | `string` | n/a | yes |
| <a name="input_subnet_private_c"></a> [subnet\_private\_c](#input\_subnet\_private\_c) | private subnet az-c | `string` | n/a | yes |
| <a name="input_subnet_public_a"></a> [subnet\_public\_a](#input\_subnet\_public\_a) | public subnet az-a | `string` | n/a | yes |
| <a name="input_subnet_public_b"></a> [subnet\_public\_b](#input\_subnet\_public\_b) | public subnet az-b | `string` | n/a | yes |
| <a name="input_subnet_public_c"></a> [subnet\_public\_c](#input\_subnet\_public\_c) | public subnet az-c | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_webserver_version_1"></a> [webserver\_version\_1](#input\_webserver\_version\_1) | Webserver Version 1 | `string` | `"stable"` | no |
| <a name="input_webserver_version_2"></a> [webserver\_version\_2](#input\_webserver\_version\_2) | Webserver Version 2 | `string` | `"latest"` | no |
| <a name="input_weight_1"></a> [weight\_1](#input\_weight\_1) | weight for alb web-server-1 | `any` | n/a | yes |
| <a name="input_weight_2"></a> [weight\_2](#input\_weight\_2) | weight for alb web-server-2 | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cgw_arns"></a> [cgw\_arns](#output\_cgw\_arns) | List of ARNs of Customer Gateway |
| <a name="output_cgw_ids"></a> [cgw\_ids](#output\_cgw\_ids) | List of IDs of Customer Gateway |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | ARN that identifies the cluster |
| <a name="output_cluster_autoscaling_capacity_providers"></a> [cluster\_autoscaling\_capacity\_providers](#output\_cluster\_autoscaling\_capacity\_providers) | Map of capacity providers created and their attributes |
| <a name="output_cluster_capacity_providers"></a> [cluster\_capacity\_providers](#output\_cluster\_capacity\_providers) | Map of cluster capacity providers attributes |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | ID that identifies the cluster |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Name that identifies the cluster |
| <a name="output_database_internet_gateway_route_id"></a> [database\_internet\_gateway\_route\_id](#output\_database\_internet\_gateway\_route\_id) | ID of the database internet gateway route |
| <a name="output_database_ipv6_egress_route_id"></a> [database\_ipv6\_egress\_route\_id](#output\_database\_ipv6\_egress\_route\_id) | ID of the database IPv6 egress route |
| <a name="output_database_nat_gateway_route_ids"></a> [database\_nat\_gateway\_route\_ids](#output\_database\_nat\_gateway\_route\_ids) | List of IDs of the database nat gateway route |
| <a name="output_database_network_acl_arn"></a> [database\_network\_acl\_arn](#output\_database\_network\_acl\_arn) | ARN of the database network ACL |
| <a name="output_database_network_acl_id"></a> [database\_network\_acl\_id](#output\_database\_network\_acl\_id) | ID of the database network ACL |
| <a name="output_database_route_table_association_ids"></a> [database\_route\_table\_association\_ids](#output\_database\_route\_table\_association\_ids) | List of IDs of the database route table association |
| <a name="output_database_route_table_ids"></a> [database\_route\_table\_ids](#output\_database\_route\_table\_ids) | List of IDs of database route tables |
| <a name="output_database_subnet_arns"></a> [database\_subnet\_arns](#output\_database\_subnet\_arns) | List of ARNs of database subnets |
| <a name="output_database_subnet_group"></a> [database\_subnet\_group](#output\_database\_subnet\_group) | ID of database subnet group |
| <a name="output_database_subnet_group_name"></a> [database\_subnet\_group\_name](#output\_database\_subnet\_group\_name) | Name of database subnet group |
| <a name="output_database_subnets"></a> [database\_subnets](#output\_database\_subnets) | List of IDs of database subnets |
| <a name="output_database_subnets_cidr_blocks"></a> [database\_subnets\_cidr\_blocks](#output\_database\_subnets\_cidr\_blocks) | List of cidr\_blocks of database subnets |
| <a name="output_database_subnets_ipv6_cidr_blocks"></a> [database\_subnets\_ipv6\_cidr\_blocks](#output\_database\_subnets\_ipv6\_cidr\_blocks) | List of IPv6 cidr\_blocks of database subnets in an IPv6 enabled VPC |
| <a name="output_default_network_acl_id"></a> [default\_network\_acl\_id](#output\_default\_network\_acl\_id) | The ID of the default network ACL |
| <a name="output_default_route_table_id"></a> [default\_route\_table\_id](#output\_default\_route\_table\_id) | The ID of the default route table |
| <a name="output_default_security_group_id"></a> [default\_security\_group\_id](#output\_default\_security\_group\_id) | The ID of the security group created by default on VPC creation |
| <a name="output_default_vpc_arn"></a> [default\_vpc\_arn](#output\_default\_vpc\_arn) | The ARN of the Default VPC |
| <a name="output_default_vpc_cidr_block"></a> [default\_vpc\_cidr\_block](#output\_default\_vpc\_cidr\_block) | The CIDR block of the Default VPC |
| <a name="output_default_vpc_default_network_acl_id"></a> [default\_vpc\_default\_network\_acl\_id](#output\_default\_vpc\_default\_network\_acl\_id) | The ID of the default network ACL of the Default VPC |
| <a name="output_default_vpc_default_route_table_id"></a> [default\_vpc\_default\_route\_table\_id](#output\_default\_vpc\_default\_route\_table\_id) | The ID of the default route table of the Default VPC |
| <a name="output_default_vpc_default_security_group_id"></a> [default\_vpc\_default\_security\_group\_id](#output\_default\_vpc\_default\_security\_group\_id) | The ID of the security group created by default on Default VPC creation |
| <a name="output_default_vpc_enable_dns_hostnames"></a> [default\_vpc\_enable\_dns\_hostnames](#output\_default\_vpc\_enable\_dns\_hostnames) | Whether or not the Default VPC has DNS hostname support |
| <a name="output_default_vpc_enable_dns_support"></a> [default\_vpc\_enable\_dns\_support](#output\_default\_vpc\_enable\_dns\_support) | Whether or not the Default VPC has DNS support |
| <a name="output_default_vpc_id"></a> [default\_vpc\_id](#output\_default\_vpc\_id) | The ID of the Default VPC |
| <a name="output_default_vpc_instance_tenancy"></a> [default\_vpc\_instance\_tenancy](#output\_default\_vpc\_instance\_tenancy) | Tenancy of instances spin up within Default VPC |
| <a name="output_default_vpc_main_route_table_id"></a> [default\_vpc\_main\_route\_table\_id](#output\_default\_vpc\_main\_route\_table\_id) | The ID of the main route table associated with the Default VPC |
| <a name="output_dhcp_options_id"></a> [dhcp\_options\_id](#output\_dhcp\_options\_id) | The ID of the DHCP options |
| <a name="output_egress_only_internet_gateway_id"></a> [egress\_only\_internet\_gateway\_id](#output\_egress\_only\_internet\_gateway\_id) | The ID of the egress only Internet Gateway |
| <a name="output_elasticache_network_acl_arn"></a> [elasticache\_network\_acl\_arn](#output\_elasticache\_network\_acl\_arn) | ARN of the elasticache network ACL |
| <a name="output_elasticache_network_acl_id"></a> [elasticache\_network\_acl\_id](#output\_elasticache\_network\_acl\_id) | ID of the elasticache network ACL |
| <a name="output_elasticache_route_table_association_ids"></a> [elasticache\_route\_table\_association\_ids](#output\_elasticache\_route\_table\_association\_ids) | List of IDs of the elasticache route table association |
| <a name="output_elasticache_route_table_ids"></a> [elasticache\_route\_table\_ids](#output\_elasticache\_route\_table\_ids) | List of IDs of elasticache route tables |
| <a name="output_elasticache_subnet_arns"></a> [elasticache\_subnet\_arns](#output\_elasticache\_subnet\_arns) | List of ARNs of elasticache subnets |
| <a name="output_elasticache_subnet_group"></a> [elasticache\_subnet\_group](#output\_elasticache\_subnet\_group) | ID of elasticache subnet group |
| <a name="output_elasticache_subnet_group_name"></a> [elasticache\_subnet\_group\_name](#output\_elasticache\_subnet\_group\_name) | Name of elasticache subnet group |
| <a name="output_elasticache_subnets"></a> [elasticache\_subnets](#output\_elasticache\_subnets) | List of IDs of elasticache subnets |
| <a name="output_elasticache_subnets_cidr_blocks"></a> [elasticache\_subnets\_cidr\_blocks](#output\_elasticache\_subnets\_cidr\_blocks) | List of cidr\_blocks of elasticache subnets |
| <a name="output_elasticache_subnets_ipv6_cidr_blocks"></a> [elasticache\_subnets\_ipv6\_cidr\_blocks](#output\_elasticache\_subnets\_ipv6\_cidr\_blocks) | List of IPv6 cidr\_blocks of elasticache subnets in an IPv6 enabled VPC |
| <a name="output_http_tcp_listener_arns"></a> [http\_tcp\_listener\_arns](#output\_http\_tcp\_listener\_arns) | The ARN of the TCP and HTTP load balancer listeners created. |
| <a name="output_http_tcp_listener_ids"></a> [http\_tcp\_listener\_ids](#output\_http\_tcp\_listener\_ids) | The IDs of the TCP and HTTP load balancer listeners created. |
| <a name="output_https_listener_arns"></a> [https\_listener\_arns](#output\_https\_listener\_arns) | The ARNs of the HTTPS load balancer listeners created. |
| <a name="output_https_listener_ids"></a> [https\_listener\_ids](#output\_https\_listener\_ids) | The IDs of the load balancer listeners created. |
| <a name="output_igw_arn"></a> [igw\_arn](#output\_igw\_arn) | The ARN of the Internet Gateway |
| <a name="output_igw_id"></a> [igw\_id](#output\_igw\_id) | The ID of the Internet Gateway |
| <a name="output_intra_network_acl_arn"></a> [intra\_network\_acl\_arn](#output\_intra\_network\_acl\_arn) | ARN of the intra network ACL |
| <a name="output_intra_network_acl_id"></a> [intra\_network\_acl\_id](#output\_intra\_network\_acl\_id) | ID of the intra network ACL |
| <a name="output_intra_route_table_association_ids"></a> [intra\_route\_table\_association\_ids](#output\_intra\_route\_table\_association\_ids) | List of IDs of the intra route table association |
| <a name="output_intra_route_table_ids"></a> [intra\_route\_table\_ids](#output\_intra\_route\_table\_ids) | List of IDs of intra route tables |
| <a name="output_intra_subnet_arns"></a> [intra\_subnet\_arns](#output\_intra\_subnet\_arns) | List of ARNs of intra subnets |
| <a name="output_intra_subnets"></a> [intra\_subnets](#output\_intra\_subnets) | List of IDs of intra subnets |
| <a name="output_intra_subnets_cidr_blocks"></a> [intra\_subnets\_cidr\_blocks](#output\_intra\_subnets\_cidr\_blocks) | List of cidr\_blocks of intra subnets |
| <a name="output_intra_subnets_ipv6_cidr_blocks"></a> [intra\_subnets\_ipv6\_cidr\_blocks](#output\_intra\_subnets\_ipv6\_cidr\_blocks) | List of IPv6 cidr\_blocks of intra subnets in an IPv6 enabled VPC |
| <a name="output_lb_arn"></a> [lb\_arn](#output\_lb\_arn) | The ID and ARN of the load balancer we created. |
| <a name="output_lb_arn_suffix"></a> [lb\_arn\_suffix](#output\_lb\_arn\_suffix) | ARN suffix of our load balancer - can be used with CloudWatch. |
| <a name="output_lb_dns_name"></a> [lb\_dns\_name](#output\_lb\_dns\_name) | The DNS name of the load balancer. |
| <a name="output_lb_id"></a> [lb\_id](#output\_lb\_id) | The ID and ARN of the load balancer we created. |
| <a name="output_lb_zone_id"></a> [lb\_zone\_id](#output\_lb\_zone\_id) | The zone\_id of the load balancer to assist with creating DNS records. |
| <a name="output_nat_ids"></a> [nat\_ids](#output\_nat\_ids) | List of allocation ID of Elastic IPs created for AWS NAT Gateway |
| <a name="output_nat_public_ips"></a> [nat\_public\_ips](#output\_nat\_public\_ips) | List of public Elastic IPs created for AWS NAT Gateway |
| <a name="output_natgw_ids"></a> [natgw\_ids](#output\_natgw\_ids) | List of NAT Gateway IDs |
| <a name="output_outpost_network_acl_arn"></a> [outpost\_network\_acl\_arn](#output\_outpost\_network\_acl\_arn) | ARN of the outpost network ACL |
| <a name="output_outpost_network_acl_id"></a> [outpost\_network\_acl\_id](#output\_outpost\_network\_acl\_id) | ID of the outpost network ACL |
| <a name="output_outpost_subnet_arns"></a> [outpost\_subnet\_arns](#output\_outpost\_subnet\_arns) | List of ARNs of outpost subnets |
| <a name="output_outpost_subnets"></a> [outpost\_subnets](#output\_outpost\_subnets) | List of IDs of outpost subnets |
| <a name="output_outpost_subnets_cidr_blocks"></a> [outpost\_subnets\_cidr\_blocks](#output\_outpost\_subnets\_cidr\_blocks) | List of cidr\_blocks of outpost subnets |
| <a name="output_outpost_subnets_ipv6_cidr_blocks"></a> [outpost\_subnets\_ipv6\_cidr\_blocks](#output\_outpost\_subnets\_ipv6\_cidr\_blocks) | List of IPv6 cidr\_blocks of outpost subnets in an IPv6 enabled VPC |
| <a name="output_private_ipv6_egress_route_ids"></a> [private\_ipv6\_egress\_route\_ids](#output\_private\_ipv6\_egress\_route\_ids) | List of IDs of the ipv6 egress route |
| <a name="output_private_nat_gateway_route_ids"></a> [private\_nat\_gateway\_route\_ids](#output\_private\_nat\_gateway\_route\_ids) | List of IDs of the private nat gateway route |
| <a name="output_private_network_acl_arn"></a> [private\_network\_acl\_arn](#output\_private\_network\_acl\_arn) | ARN of the private network ACL |
| <a name="output_private_network_acl_id"></a> [private\_network\_acl\_id](#output\_private\_network\_acl\_id) | ID of the private network ACL |
| <a name="output_private_route_table_association_ids"></a> [private\_route\_table\_association\_ids](#output\_private\_route\_table\_association\_ids) | List of IDs of the private route table association |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | List of IDs of private route tables |
| <a name="output_private_subnet_arns"></a> [private\_subnet\_arns](#output\_private\_subnet\_arns) | List of ARNs of private subnets |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of IDs of private subnets |
| <a name="output_private_subnets_cidr_blocks"></a> [private\_subnets\_cidr\_blocks](#output\_private\_subnets\_cidr\_blocks) | List of cidr\_blocks of private subnets |
| <a name="output_private_subnets_ipv6_cidr_blocks"></a> [private\_subnets\_ipv6\_cidr\_blocks](#output\_private\_subnets\_ipv6\_cidr\_blocks) | List of IPv6 cidr\_blocks of private subnets in an IPv6 enabled VPC |
| <a name="output_public_internet_gateway_ipv6_route_id"></a> [public\_internet\_gateway\_ipv6\_route\_id](#output\_public\_internet\_gateway\_ipv6\_route\_id) | ID of the IPv6 internet gateway route |
| <a name="output_public_internet_gateway_route_id"></a> [public\_internet\_gateway\_route\_id](#output\_public\_internet\_gateway\_route\_id) | ID of the internet gateway route |
| <a name="output_public_network_acl_arn"></a> [public\_network\_acl\_arn](#output\_public\_network\_acl\_arn) | ARN of the public network ACL |
| <a name="output_public_network_acl_id"></a> [public\_network\_acl\_id](#output\_public\_network\_acl\_id) | ID of the public network ACL |
| <a name="output_public_route_table_association_ids"></a> [public\_route\_table\_association\_ids](#output\_public\_route\_table\_association\_ids) | List of IDs of the public route table association |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | List of IDs of public route tables |
| <a name="output_public_subnet_arns"></a> [public\_subnet\_arns](#output\_public\_subnet\_arns) | List of ARNs of public subnets |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of IDs of public subnets |
| <a name="output_public_subnets_cidr_blocks"></a> [public\_subnets\_cidr\_blocks](#output\_public\_subnets\_cidr\_blocks) | List of cidr\_blocks of public subnets |
| <a name="output_public_subnets_ipv6_cidr_blocks"></a> [public\_subnets\_ipv6\_cidr\_blocks](#output\_public\_subnets\_ipv6\_cidr\_blocks) | List of IPv6 cidr\_blocks of public subnets in an IPv6 enabled VPC |
| <a name="output_redshift_network_acl_arn"></a> [redshift\_network\_acl\_arn](#output\_redshift\_network\_acl\_arn) | ARN of the redshift network ACL |
| <a name="output_redshift_network_acl_id"></a> [redshift\_network\_acl\_id](#output\_redshift\_network\_acl\_id) | ID of the redshift network ACL |
| <a name="output_redshift_public_route_table_association_ids"></a> [redshift\_public\_route\_table\_association\_ids](#output\_redshift\_public\_route\_table\_association\_ids) | List of IDs of the public redshidt route table association |
| <a name="output_redshift_route_table_association_ids"></a> [redshift\_route\_table\_association\_ids](#output\_redshift\_route\_table\_association\_ids) | List of IDs of the redshift route table association |
| <a name="output_redshift_route_table_ids"></a> [redshift\_route\_table\_ids](#output\_redshift\_route\_table\_ids) | List of IDs of redshift route tables |
| <a name="output_redshift_subnet_arns"></a> [redshift\_subnet\_arns](#output\_redshift\_subnet\_arns) | List of ARNs of redshift subnets |
| <a name="output_redshift_subnet_group"></a> [redshift\_subnet\_group](#output\_redshift\_subnet\_group) | ID of redshift subnet group |
| <a name="output_redshift_subnets"></a> [redshift\_subnets](#output\_redshift\_subnets) | List of IDs of redshift subnets |
| <a name="output_redshift_subnets_cidr_blocks"></a> [redshift\_subnets\_cidr\_blocks](#output\_redshift\_subnets\_cidr\_blocks) | List of cidr\_blocks of redshift subnets |
| <a name="output_redshift_subnets_ipv6_cidr_blocks"></a> [redshift\_subnets\_ipv6\_cidr\_blocks](#output\_redshift\_subnets\_ipv6\_cidr\_blocks) | List of IPv6 cidr\_blocks of redshift subnets in an IPv6 enabled VPC |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | The ARN of the security group |
| <a name="output_security_group_description"></a> [security\_group\_description](#output\_security\_group\_description) | The description of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | The name of the security group |
| <a name="output_security_group_owner_id"></a> [security\_group\_owner\_id](#output\_security\_group\_owner\_id) | The owner ID |
| <a name="output_security_group_vpc_id"></a> [security\_group\_vpc\_id](#output\_security\_group\_vpc\_id) | The VPC ID |
| <a name="output_target_group_arn_suffixes"></a> [target\_group\_arn\_suffixes](#output\_target\_group\_arn\_suffixes) | ARN suffixes of our target groups - can be used with CloudWatch. |
| <a name="output_target_group_arns"></a> [target\_group\_arns](#output\_target\_group\_arns) | ARNs of the target groups. Useful for passing to your Auto Scaling group. |
| <a name="output_target_group_attachments"></a> [target\_group\_attachments](#output\_target\_group\_attachments) | ARNs of the target group attachment IDs. |
| <a name="output_target_group_names"></a> [target\_group\_names](#output\_target\_group\_names) | Name of the target group. Useful for passing to your CodeDeploy Deployment Group. |
| <a name="output_this_customer_gateway"></a> [this\_customer\_gateway](#output\_this\_customer\_gateway) | Map of Customer Gateway attributes |
| <a name="output_vgw_arn"></a> [vgw\_arn](#output\_vgw\_arn) | The ARN of the VPN Gateway |
| <a name="output_vgw_id"></a> [vgw\_id](#output\_vgw\_id) | The ID of the VPN Gateway |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | The ARN of the VPC |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_enable_dns_hostnames"></a> [vpc\_enable\_dns\_hostnames](#output\_vpc\_enable\_dns\_hostnames) | Whether or not the VPC has DNS hostname support |
| <a name="output_vpc_enable_dns_support"></a> [vpc\_enable\_dns\_support](#output\_vpc\_enable\_dns\_support) | Whether or not the VPC has DNS support |
| <a name="output_vpc_flow_log_cloudwatch_iam_role_arn"></a> [vpc\_flow\_log\_cloudwatch\_iam\_role\_arn](#output\_vpc\_flow\_log\_cloudwatch\_iam\_role\_arn) | The ARN of the IAM role used when pushing logs to Cloudwatch log group |
| <a name="output_vpc_flow_log_destination_arn"></a> [vpc\_flow\_log\_destination\_arn](#output\_vpc\_flow\_log\_destination\_arn) | The ARN of the destination for VPC Flow Logs |
| <a name="output_vpc_flow_log_destination_type"></a> [vpc\_flow\_log\_destination\_type](#output\_vpc\_flow\_log\_destination\_type) | The type of the destination for VPC Flow Logs |
| <a name="output_vpc_flow_log_id"></a> [vpc\_flow\_log\_id](#output\_vpc\_flow\_log\_id) | The ID of the Flow Log resource |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vpc_instance_tenancy"></a> [vpc\_instance\_tenancy](#output\_vpc\_instance\_tenancy) | Tenancy of instances spin up within VPC |
| <a name="output_vpc_ipv6_association_id"></a> [vpc\_ipv6\_association\_id](#output\_vpc\_ipv6\_association\_id) | The association ID for the IPv6 CIDR block |
| <a name="output_vpc_ipv6_cidr_block"></a> [vpc\_ipv6\_cidr\_block](#output\_vpc\_ipv6\_cidr\_block) | The IPv6 CIDR block |
| <a name="output_vpc_main_route_table_id"></a> [vpc\_main\_route\_table\_id](#output\_vpc\_main\_route\_table\_id) | The ID of the main route table associated with this VPC |
| <a name="output_vpc_owner_id"></a> [vpc\_owner\_id](#output\_vpc\_owner\_id) | The ID of the AWS account that owns the VPC |
| <a name="output_vpc_secondary_cidr_blocks"></a> [vpc\_secondary\_cidr\_blocks](#output\_vpc\_secondary\_cidr\_blocks) | List of secondary CIDR blocks of the VPC |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
