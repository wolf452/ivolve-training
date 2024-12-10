
# Terraform Project: Nginx EC2 Instances in AWS

## Overview
This Terraform project provisions the following AWS infrastructure:
1. A VPC with two public subnets.
2. An Internet Gateway for public access.
3. A public Route Table associated with the public subnets.
4. A Security Group allowing inbound access for HTTP (port 80) and SSH (port 22).
5. Two EC2 instances (one in each public subnet) running Nginx, with user data to install and configure Nginx.

## Requirements
- Terraform v1.5+.
- AWS CLI installed and configured with credentials.
- Access to the specified AWS region (default: us-east-1).

## Variables
The project uses the following input variables:

| Variable Name         | Description                                 | Default     |
|-----------------------|---------------------------------------------|-------------|
| region               | AWS region to deploy the infrastructure    | us-east-1   |
| vpc_cidr             | CIDR block for the VPC                     | 10.0.0.0/16 |
| public_subnet_cidrs  | List of CIDR blocks for public subnets      | ["10.0.1.0/24", "10.0.2.0/24"] |
| instance_name        | Name of the EC2 instances                  | -           |

## Outputs
The following outputs are generated after the infrastructure is deployed:

| Output Name          | Description                              |
|----------------------|------------------------------------------|
| vpc_id               | The ID of the VPC                       |
| public_subnet_ids    | List of IDs for the public subnets       |
| public_sg_id         | ID of the Security Group for EC2         |
| ec2_public_ips       | Public IPs of the EC2 instances          |

## Modules
### VPC Module
Located in `./modules/vpc`, this module provisions:
- VPC
- Public subnets
- Internet Gateway
- Public Route Table and associations
- Security Group

### EC2 Module
Located in `./modules/ec2`, this module provisions:
- EC2 instances with user data to install Nginx.

## How to Use
### 1. Clone the Repository
Clone the repository to your local machine:
```bash
git clone <repository-url>
cd <repository-folder>
2. Initialize Terraform
Initialize Terraform to download the necessary providers:

bash
Copy code
terraform init
3. Plan the Infrastructure
Run Terraform plan to preview the changes that will be made:

bash
Copy code
terraform plan -var="instance_name=nginx-instance" -var="region=us-east-1"
4. Apply the Configuration
Deploy the infrastructure by applying the Terraform plan:



VPC ID
Subnet IDs
Security Group ID
Public IPs of the EC2 instances
6. Nginx Verification
Once the resources are deployed, open a web browser and enter the public IP address of one of the EC2 instances:

text
Copy code
http://<EC2_PUBLIC_IP>
You should see a welcome message: Welcome to Nginx on <hostname>.

7. Clean Up
To destroy the resources created by this project, run the following command:

bash
Copy code
terraform destroy
Directory Structure
text
Copy code
.
├── main.tf                 # Main Terraform configuration
├── variables.tf            # Input variable definitions
├── outputs.tf              # Output definitions
├── modules/
│   ├── vpc/                # VPC module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2/                # EC2 module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
