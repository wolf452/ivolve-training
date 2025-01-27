# Terraform Infrastructure

This repository contains the Terraform configuration for deploying a VPC with EC2 instances and Load Balancers in AWS.
![load](https://github.com/user-attachments/assets/1cedf34c-c92e-4d2b-9451-3af73539fc41)

## Modules

The project consists of the following modules:

1. **vpc** - Creates the VPC and associated resources like subnets, internet gateway, route tables, and security groups.
2. **ec2** - Creates EC2 instances for proxy and backend servers.
3. **lb** - Creates Load Balancers (Application Load Balancers) and associates them with the EC2 instances.

## Variables

### `ami_id`
- **Description**: The ID of the AMI to use for EC2 instances.
- **Type**: String

### `instance_type`
- **Description**: The type of EC2 instance to launch.
- **Type**: String

### `security_group_id`
- **Description**: The ID of the security group.
- **Type**: String

### `vpc_id`
- **Description**: The VPC ID where EC2 instances will be launched.
- **Type**: String

### `subnet_ids`
- **Description**: List of subnet IDs for the EC2 instances.
- **Type**: List of Strings

### `second_lb_dns`
- **Description**: The DNS name for the second load balancer.
- **Type**: String

## Outputs

### `vpc_id`
- **Description**: The ID of the created VPC.
- **Type**: String

### `subnet_ids`
- **Description**: The IDs of the subnets created.
- **Type**: List of Strings

### `security_group_id`
- **Description**: The ID of the security group.
- **Type**: String

### `proxy_instance_ids`
- **Description**: The IDs of the proxy EC2 instances.
- **Type**: List of Strings

### `backend_instance_ids`
- **Description**: The IDs of the backend EC2 instances.
- **Type**: List of Strings

## Resources

### VPC
- Creates a VPC with CIDR block `10.0.0.0/16`.
- Subnets: 4 subnets (2 in `us-east-1a` and 2 in `us-east-1b`).
- Public Route Table and associations with subnets.
- Internet Gateway for external access.

### EC2 Instances
- **Proxy Instances**: Two instances running Nginx as a reverse proxy.
- **Backend Instances**: Two instances running Apache2 to serve as backend servers.

### Load Balancers
- **First Load Balancer**: Distributes traffic to the first two backend instances.
- **Second Load Balancer**: Distributes traffic to the last two backend instances.

## How to Use

1. Clone the repository:
    ```bash
    git clone <repo-url>
    cd <repo-directory>
    ```

2. Initialize Terraform:
    ```bash
    terraform init
    ```

3. Apply the configuration:
    ```bash
    terraform apply
    ```

4. Terraform will ask for the necessary input variables (`ami_id`, `instance_type`, etc.), or you can provide them through a `.tfvars` file.

5. After the deployment is complete, Terraform will output the VPC ID, subnet IDs, security group ID, EC2 instance IDs, and Load Balancer DNS.

## Cleanup

To destroy all resources created by Terraform:

```bash
terraform destroy
