variable "lb_name" {
  description = "Name of the Load Balancer"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "backend_instance_ids" {
  description = "The list of backend EC2 instance IDs"
  type        = list(string)
}
