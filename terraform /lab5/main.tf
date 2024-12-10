module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source            = "./modules/ec2"
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.subnet_ids
  security_group_id = module.vpc.security_group_id
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  second_lb_dns     = module.lb2.lb_dns
}

module "lb1" {
  source                = "./modules/lb"
  lb_name               = "first-lb"
  subnet_ids            = slice(module.vpc.subnet_ids, 0, 2) # Use the first 2 subnets
  security_group_id     = module.vpc.security_group_id
  vpc_id                = module.vpc.vpc_id
  backend_instance_ids  = slice(module.ec2.backend_instance_ids, 0, 2) # Use the first 2 backend instances
}

module "lb2" {
  source                = "./modules/lb"
  lb_name               = "second-lb"
  subnet_ids            = slice(module.vpc.subnet_ids, 2, 4) # Use the last 2 subnets
  security_group_id     = module.vpc.security_group_id
  vpc_id                = module.vpc.vpc_id
  backend_instance_ids  = slice(module.ec2.backend_instance_ids, 2, length(module.ec2.backend_instance_ids)) # Use the last 2 backend instances
}
