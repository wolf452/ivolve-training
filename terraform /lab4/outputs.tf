output "ec2_public_ips" {
  description = "Public IPs of the EC2 instances"
  value       = [module.ec2_subnet_1.public_ip, module.ec2_subnet_2.public_ip]
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}
