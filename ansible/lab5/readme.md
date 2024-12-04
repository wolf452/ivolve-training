
# Ansible: Dynamic Inventory and Apache Installation Using Ansible Galaxy

## Overview
This project demonstrates how to:
- Set up Ansible Dynamic Inventories to automatically discover and manage infrastructure, specifically for AWS EC2 instances.
- Use an Ansible Galaxy role to install and configure Apache on the target servers.

## Prerequisites
Ensure the following are installed and configured:
- Ansible 2.9+
- Python 3.6+
- AWS CLI configured with valid credentials using `aws configure`
- Required Python libraries: `boto3` and `botocore`
- SSH access to your target servers

## Project Structure
```
project/
├── ansible.cfg              # Ansible configuration file
├── aws_ec2.yml              # Dynamic inventory script for AWS
├── install_apache.yml       # Main playbook to install Apache
├── galaxy_roles/            # Directory for Galaxy roles
│   └── geerlingguy.apache/  # Installed Apache role
```

## Step-by-Step Guide

### 1. Set Up AWS Dynamic Inventory
Dynamic inventory allows Ansible to automatically fetch EC2 instance details.

#### Install required Python libraries:
```bash
sudo apt install python3-boto3 python3-botocore -y
```

#### Install and configure AWS CLI:
```bash
sudo apt install awscli -y
aws configure
```

#### Install the Ansible AWS collection:
```bash
sudo ansible-galaxy collection install amazon.aws
```

#### Create and configure the AWS Dynamic Inventory:
Create the `aws_ec2.yml` file with the following content:
```yaml
plugin: amazon.aws.aws_ec2
regions:
  - us-east-1  # Replace with your AWS region
filters:
  "tag:Name": ivolve  # Filter EC2 instances based on tags
keyed_groups:
  - key: tags.Name
    prefix: tag
```
This configuration will automatically discover EC2 instances in the `us-east-1` region with the tag `Name=ivolve`.

#### Test the dynamic inventory:
Run the following command to list the discovered EC2 instances:
```bash
ansible-inventory -i aws_ec2.yml --list
```

### 2. Install Apache Using Ansible Galaxy Role

#### Search for the Apache role in Ansible Galaxy:
```bash
ansible-galaxy search apache
```

#### Install the `geerlingguy.apache` role:
```bash
ansible-galaxy install geerlingguy.apache --roles-path galaxy_roles/
```

#### Create the Playbook to Install Apache:
Create the `install_apache.yml` file with the following content:
```yaml
---
- name: Install Apache
  hosts: all
  become: yes
  roles:
    - geerlingguy.apache
```

### 3. Running the Playbook
To run the playbook on the dynamically discovered EC2 instances, use the following command:
```bash
ansible-playbook -i aws_ec2.yml install_apache.yml --private-key=your-key.pem -u ubuntu
```
Make sure to replace `your-key.pem` with your actual SSH private key and adjust the username if needed.

## Common Issues & Tips

### 1. Installing `boto3` and `botocore`:
If you encounter issues related to the `boto3` or `botocore` libraries, you can install them with:
```bash
sudo apt install python3-boto3 python3-botocore -y
```

### 2. Naming the Inventory File:
Ensure that your inventory file is named `aws_ec2.yml` for it to work with Ansible's dynamic inventory plugin.

### 3. AWS Credentials:
Ensure your AWS credentials have the necessary permissions to describe EC2 instances and create them if required.

### 4. SSH Access:
If you're having issues with SSH access to your EC2 instances, check that your private key has the correct permissions:
```bash
chmod 400 your-key.pem
```

