variable "vpc_id" {
  description = "The VPC ID where EC2 instances will be launched"
  type        = string
}

variable "subnet_ids" {
  description = "The list of subnet IDs for the EC2 instances"
  type        = list(string)
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instances"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID for the EC2 instances"
  type        = string
}

variable "second_lb_dns" {
  description = "The DNS name for the second load balancer"
  type        = string
}
