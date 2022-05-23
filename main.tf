terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
  # shared_credentials_file = "~/.aws/credentials"
  # profile = "default"
}

module "networking" {
  source      = "./networking"
  vpc-cidr    = var.vpc-cidr
  subnet-cidr = var.subnet-cidr
}

module "compute" {
  source            = "./compute"
  security_group_id = [module.networking.security_group_id]
  subnet_id         = module.networking.subnet_id
  host_os           = var.host_os
}
