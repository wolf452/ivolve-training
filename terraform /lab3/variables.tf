variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "ami_id" {
  default = "ami-0abcdef1234567890"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "nginx_count" {
  default = 1
}

variable "apache_count" {
  default = 1
}

variable "region" {
  default = "us-east-1"
}
