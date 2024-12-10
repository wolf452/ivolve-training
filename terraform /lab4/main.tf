provider "aws" {
  region = "us-east-1"
}

# VPC Module
module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
}

# EC2 Module for Subnet 1
module "ec2_subnet_1" {
  source           = "./modules/ec2"
  instance_name    = "nginx-ec2-subnet-1"
  subnet_id        = module.vpc.public_subnet_ids[0]
  security_group_id = module.vpc.public_sg_id
}

# EC2 Module for Subnet 2
module "ec2_subnet_2" {
  source           = "./modules/ec2"
  instance_name    = "nginx-ec2-subnet-2"
  subnet_id        = module.vpc.public_subnet_ids[1]
  security_group_id = module.vpc.public_sg_id
}
