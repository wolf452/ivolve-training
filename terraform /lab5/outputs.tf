output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "security_group_id" {
  value = module.vpc.security_group_id
}

output "proxy_instance_ids" {
  value = module.ec2.proxy_instance_ids
}

output "backend_instance_ids" {
  value = module.ec2.backend_instance_ids
}
