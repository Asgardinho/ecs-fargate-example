# ecs-fargate-example

Infrastructure as code for multiple AWS environments implemented with terraform and terragrunt
Folder structure showing qa and staging environment and vpc module as example
```
/
├──environments/
│  ├──terragrunt.hcl (s3 backend config)
│  ├──qa/ (the other environment)
│  └──staging/
│     ├──env.yaml (PARAMETERS) This is the only needed file to be modified 
│     └──fargate/
│        └──terragrunt.hcl (VPC CIDR and subnets) if you wanna configure the VPC CIDR and subnets
└──modules
   └──fargate/
      ├──main.tf
      ├──fargate.tf
      └──variables.tf
```
# Architecture
Frontend with ALB   
   • 2 TargetGroups with an http listener:80  
   • 1 ALB in RoundRobin you configure the weight for each targetgroup 
     
ECS backend  
   • 2 services  
   • 1-10 number of containers for each version with autoscaling  
     
S3  
   • for the terraform state file  

# How to deploy it 

You will need to install terraform and terragrunt.

https://terragrunt.gruntwork.io/docs/getting-started/install/

https://learn.hashicorp.com/tutorials/terraform/install-cli

set up AWS credentials for qa environment (replace both access and secret keys with yours)

```
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_SESSION_TOKEN=""
export AWS_ACCOUNT_ID=""
aws sts get-caller-identity
```

after cloning the repo, simply go into the environment you want to deploy
modify the env.yaml and put your AWS account_id
```
git clone git@github.com:Asgardinho/ecs-fargate-example.git
cd ecs-fargate-example/environments/staging
sed -i "s/^account_id\s*:.*/account_id: \"$AWS_ACCOUNT_ID\"/" env.yaml
```
pd: You can also modify other values like the container image, the versions to use, the weight of the load balancer

now run the terraform
```
terragrunt run-all init -upgrade
terragrunt run-all apply
```
It should take around 5 minutes
One of the outputs should be "lb_dns_name" that's the url to put on your browser and start testing
