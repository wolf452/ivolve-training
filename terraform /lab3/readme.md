
# Terraform Configuration for VPC with Nginx and Apache Servers

This Terraform configuration creates an AWS VPC with public and private subnets. It deploys Nginx servers in the public subnets and Apache servers in the private subnets. 

## Table of Contents
- [Architecture Overview](#architecture-overview)
- [Prerequisites](#prerequisites)
- [Configuration](#configuration)
- [Usage](#usage)
- [Outputs](#outputs)

## Architecture Overview
- **VPC CIDR:** `10.0.0.0/16`
- **Public Subnets:** 
  - `10.0.1.0/24` in `us-east-1a`
  - `10.0.2.0/24` in `us-east-1b`
- **Private Subnets:** 
  - `10.0.3.0/24` in `us-east-1a`
  - `10.0.4.0/24` in `us-east-1b`
- **Instances:**
  - Nginx server(s) in public subnets
  - Apache server(s) in private subnets
- **NAT Gateway:** Enables private subnets to connect to the internet.

## Prerequisites
1. Terraform installed on your machine.
2. AWS credentials configured.
3. Ensure the required AMI ID (`ami-0e2c8caa4b6378d8c`) is valid in the specified region (`us-east-1`).

## Configuration
### Variables
- `vpc_cidr`: CIDR block for the VPC.
- `public_subnet_cidrs`: List of CIDR blocks for public subnets.
- `private_subnet_cidrs`: List of CIDR blocks for private subnets.
- `availability_zones`: List of availability zones.
- `ami_id`: AMI ID for EC2 instances.
- `instance_type`: EC2 instance type (default: `t2.micro`).
- `nginx_count`: Number of Nginx instances (default: 1).
- `apache_count`: Number of Apache instances (default: 1).
- `region`: AWS region (default: `us-east-1`).

### Files
- `main.tf`: Contains the Terraform resources.
- `variables.tf`: Defines input variables.
- `terraform.tfvars`: Provides variable values.
- `output.tf`: Defines output values.

## Usage
1. Clone this repository.
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Plan the resources:
   ```bash
   terraform plan
   ```
4. Apply the configuration:
   ```bash
   terraform apply
   ```
5. Confirm the deployment by typing `yes` when prompted.

## Outputs
- `nginx_public_ip`: Public IP addresses of Nginx servers.
- `nginx_private_ip`: Private IP addresses of Nginx servers.
- `apache_public_ip`: Public IP addresses of Apache servers (if reachable).
- `apache_private_ip`: Private IP addresses of Apache servers.

## Notes
- Nginx servers are deployed in public subnets and are accessible via the internet.
- Apache servers are deployed in private subnets and are not directly accessible from the internet.
- NAT Gateway ensures private instances have outbound internet connectivity.

## Cleanup
To remove all created resources, run:
```bash
terraform destroy
```

## License
This project is licensed under the MIT License.

