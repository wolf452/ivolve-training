
# Terraform Project: AWS VPC, EC2, and CloudWatch Setup

This project uses Terraform to create and configure the following AWS resources:
- VPC
- Subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 Instance
- CloudWatch Alarm
- SNS Topic for email notifications
- DynamoDB Table for state locking (for S3 backend)

---

## Prerequisites

1. **Terraform CLI**: Install Terraform CLI on your system. Refer to [Terraform Installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
2. **AWS CLI**: Install and configure AWS CLI with the necessary credentials.
3. **S3 Bucket**: Ensure the specified S3 bucket for the Terraform backend exists.
4. **DynamoDB Table**: Ensure the DynamoDB table for Terraform state locking exists.

---

## Configuration

### Input Variables

The project uses several input variables defined in `variables.tf`. Here are their details:

| Variable      | Description                          | Default Value                  |
|---------------|--------------------------------------|--------------------------------|
| `region`      | AWS region for the resources         | `us-east-1`                    |
| `vpc_cidr`    | CIDR block for the VPC              | `10.0.0.0/16`                  |
| `subnet_cidr` | CIDR block for the subnet           | `10.0.0.0/24`                  |
| `s3_bucket`   | S3 bucket for Terraform state       | `your-terraform-state-bucket`  |
| `sns_email`   | Email for SNS notifications         | `your-email@example.com`       |
| `ami_id`      | AMI ID for EC2 instance             | `ami-0453ec754f44f9a4a`        |

Modify `terraform.tfvars` to override these defaults.

---

## Files

| File             | Description                                      |
|------------------|--------------------------------------------------|
| `main.tf`        | Main Terraform configuration for AWS resources   |
| `variables.tf`   | Input variable definitions                       |
| `terraform.tfvars` | User-specific variable values                  |
| `outputs.tf`     | Outputs for important resource attributes        |
| `README.md`      | Project documentation                            |

---

## Deployment Steps

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Validate the configuration**:
   ```bash
   terraform validate
   ```

4. **Plan the deployment**:
   ```bash
   terraform plan
   ```

5. **Apply the configuration**:
   ```bash
   terraform apply
   ```
   Confirm the prompt with `yes`.

6. **Check Outputs**:
   After the deployment, Terraform will display the outputs, including the EC2 instance details and SNS configurations.

---

## Outputs

The following outputs are defined in `outputs.tf`:

| Output                  | Description                        |
|-------------------------|------------------------------------|
| `instance_public_ip`    | Public IP of the EC2 instance     |
| `instance_private_ip`   | Private IP of the EC2 instance    |

---

## SNS Email Notification

- A CloudWatch Alarm monitors the CPU utilization of the EC2 instance. If it exceeds 70%, a notification is sent to the email specified in `sns_email`.
- **Important**: Confirm the subscription email sent to the provided email address.

---

## Clean Up

To destroy all resources created by Terraform:
```bash
terraform destroy
```
Confirm the prompt with `yes`.

---

## Notes

- Ensure the specified S3 bucket and DynamoDB table exist before running the configuration.
- Replace `your-terraform-state-bucket` and `your-email@example.com` in `terraform.tfvars` with your actual values.
- Always use `terraform plan` to preview changes before applying them.

