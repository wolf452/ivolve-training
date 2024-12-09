# Define variable for AWS region
variable "region" {
  description = "AWS region for resources"
  default     = "us-east-1"
}

# Define variable for VPC CIDR block
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

# Define variable for Subnet CIDR block
variable "subnet_cidr" {
  description = "CIDR block for the Subnet"
  default     = "10.0.0.0/24"
}

# Define variable for S3 bucket for state
variable "s3_bucket" {
  description = "S3 bucket for Terraform state"
  default     = "your-terraform-state-bucket"  # تأكد من وجود هذا الـ Bucket في AWS
}

# Define variable for SNS topic email
variable "sns_email" {
  description = "Email address for SNS alerts"
  type  = string
}

# Define variable for AMI
variable "ami_id" {
  description = "AMI ID for EC2 instance"
  default     = "ami-0453ec754f44f9a4a"
}
