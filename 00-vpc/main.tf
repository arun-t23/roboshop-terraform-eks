module "vpc" {

  source  = "git::https://github.com/arun-t23/terraform-aws-vpc-module.git?ref=main"

  ### VPC VARIABLES passing to module
  cidr_block   = var.cidr
  project_name = var.project_name
  environment  = var.environment
  vpc_tags     = var.tags

  ## SUBNET variables passing to module
  public_subnet_cidrs    = var.public_subnet_cidrs


  ### Private SUBNET passing to module
  private_subnet_cidrs = var.private_subnet_cidrs 

  ### DATABASE SUBNET passing to module
  database_subnet_cidrs = var.database_subnet_cidrs

  is_vpc_peering_required = true
}
