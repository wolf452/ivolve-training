
# Terraform AWS Infrastructure Setup

This project uses Terraform to create an AWS infrastructure that includes an EC2 instance, RDS MySQL database, and related networking components. The resources are created within an existing VPC and configured with necessary security groups, subnets, and routing.

## Overview

The infrastructure consists of the following components:

- **VPC**: Uses an existing VPC identified by the tag `Name = ivolve`.
- **Subnets**: Two subnets (public and private) are created within the VPC.
- **Security Groups**: Two security groups are created, one for the EC2 instance and one for the RDS instance.
- **EC2 Instance**: A `t2.micro` EC2 instance is created in the public subnet with SSH access.
- **RDS Instance**: A MySQL RDS database instance (`db.t3.micro`) is created in the private subnet.
- **Internet Gateway & Route Table**: An internet gateway is created for the VPC, and a public route table is configured for internet access.

## Prerequisites

- Terraform installed (version 1.0 or higher)
- AWS account with access credentials
- AWS CLI configured with appropriate permissions
- Existing VPC tagged as `ivolve`

## Configuration

### Variables

The following variables can be customized by modifying the `terraform.tfvars` or directly within the `main.tf` file:

- **region**: AWS region (default: `us-east-1`)
- **environment**: Environment name (default: `production`)
- **public_subnet_cidr**: CIDR block for the public subnet (default: `10.0.1.0/24`)
- **private_subnet_cidr**: CIDR block for the private subnet (default: `10.0.2.0/24`)
- **instance_type**: EC2 instance type (default: `t2.micro`)
- **db_instance_class**: RDS DB instance class (default: `db.t2.micro`)
- **db_password**: Password for the RDS database (make sure to set this as a secure value)

### Example `terraform.tfvars`

```hcl
region                = "us-east-1"
environment           = "production"
public_subnet_cidr    = "10.0.1.0/24"
private_subnet_cidr   = "10.0.2.0/24"
instance_type         = "t2.micro"
db_instance_class     = "db.t2.micro"
db_password           = "your-secure-db-password"
```

## Deployment Steps

### Clone the Repository

Clone the repository containing the Terraform configuration files.

```bash
git clone https://your-repository-url.git
cd your-repository-folder
```

### Initialize Terraform

Run the following command to initialize the Terraform working directory, download required providers, and configure the environment.

```bash
terraform init
```

### Plan the Deployment

Run the `terraform plan` command to see what resources will be created or modified:

```bash
terraform plan
```

### Apply the Configuration

Run the following command to apply the Terraform configuration and create the infrastructure:

```bash
terraform apply
```

You will be prompted to confirm the creation of resources by typing `yes`.

## Outputs

After applying the configuration, Terraform will output the following details:

- **EC2 Public IP**: The public IP of the EC2 instance.
- **RDS Endpoint**: The endpoint of the MySQL RDS instance.

Example outputs:

```bash
EC2 Public IP: 54.123.45.67
RDS Endpoint: ivolve-database.cq8hfh9ltnhb.us-east-1.rds.amazonaws.com
```

## Clean Up

To delete the resources created by Terraform, run:

```bash
terraform destroy
```

This will tear down all the resources (EC2, RDS, subnets, etc.) created during the `apply` step.

## Notes

- Ensure your AWS credentials have sufficient permissions to create VPC resources, EC2 instances, RDS instances, and related networking components.
- Adjust the `ami` ID in the EC2 instance configuration if you're using a different region or AMI.
- Be sure to set a secure password for the RDS instance.

## Troubleshooting

- If you encounter issues with subnet CIDR conflicts, ensure that the CIDR blocks for your subnets do not overlap with any existing subnets in the VPC.
- For database version issues, check the available versions for MySQL on AWS RDS and update the `engine_version` accordingly.

