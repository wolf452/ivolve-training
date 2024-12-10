variable "ami_id" {
  description = "The ID of the AMI to use for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
