variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "subnet_count" {
  description = "Number of subnets"
  default     = 4
}
