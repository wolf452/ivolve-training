
# **Setup AWS Account with IAM Groups, Users, and Billing Alarm**

This guide provides detailed steps to create an AWS account, configure billing alarms, set up IAM groups and users, and verify access permissions.

---

## **Objective**
- Create AWS account.
- Set up a billing alarm.
- Create 2 IAM groups:
  - **Admin**: Full administrative permissions.
  - **Developer**: Access to EC2 only.
- Create users:
  - **Admin-1**: Console access only, with MFA enabled.
  - **Admin-2-Prog**: CLI access only.
  - **Dev-User**: Programmatic and console access.
- List users and groups using AWS CLI.
- Test access permissions for **Dev-User** on EC2 and S3.

---

## **Steps**

### **1. Enable Billing Alerts**
1. Log in to the AWS Management Console.
2. Navigate to **Billing** > **Preferences**.
3. Enable **Receive Billing Alerts**.
4. Save the changes.

### **2. Create a Billing Alarm**
1. Go to the **CloudWatch** service in the AWS Console.
2. Navigate to **Alarms** > **Create Alarm**.
3. Select **Billing** > **Total Estimated Charge** as the metric.
4. Set a threshold (e.g., USD 10).
5. Configure notifications via SNS (e.g., email alerts).
6. Complete the alarm creation.

---

### **3. IAM Groups**
#### **Create Admin Group**
- **Permissions**: Full administrative access.
- AWS CLI Commands:
  ```bash
  aws iam create-group --group-name admin
  aws iam attach-group-policy --group-name admin --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
  ```

#### **Create Developer Group**
- **Permissions**: Access to EC2 only.
- AWS CLI Commands:
  ```bash
  aws iam create-group --group-name developer
  aws iam attach-group-policy --group-name developer --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess
  ```

---

### **4. IAM Users**
#### **Admin-1 User**
- **Access Type**: Console access only with MFA.
- AWS CLI Commands:
  ```bash
  aws iam create-user --user-name admin-1
  aws iam add-user-to-group --user-name admin-1 --group-name admin
  aws iam create-login-profile --user-name admin-1 --password "SecurePassword123!" --password-reset-required
  ```
- Enable MFA:
  - Go to **IAM** > **Users** > **admin-1** > **Security Credentials**.
  - Click **Manage MFA Device** and follow the instructions.

#### **Admin-2-Prog User**
- **Access Type**: CLI access only.
- AWS CLI Commands:
  ```bash
  aws iam create-user --user-name admin-2-prog
  aws iam add-user-to-group --user-name admin-2-prog --group-name admin
  aws iam create-access-key --user-name admin-2-prog
  ```

#### **Dev-User**
- **Access Type**: Programmatic and console access.
- AWS CLI Commands:
  ```bash
  aws iam create-user --user-name dev-user
  aws iam add-user-to-group --user-name dev-user --group-name developer
  aws iam create-login-profile --user-name dev-user --password "SecurePassword456!" --password-reset-required
  aws iam create-access-key --user-name dev-user
  ```

---

### **5. List Users and Groups**
- List all users:
  ```bash
  aws iam list-users
  ```
- List all groups:
  ```bash
  aws iam list-groups
  ```

---

### **6. Test Permissions**
#### **Dev-User Access**
1. Configure AWS CLI using **Dev-User** credentials:
   ```bash
   aws configure
   ```
2. Verify EC2 access:
   ```bash
   aws ec2 describe-instances
   ```
3. Verify S3 access:
   ```bash
   aws s3 ls
   ```
   - **Expected Result**: EC2 access should be allowed, while S3 access should be denied.

---

### **Notes**
- Replace placeholder passwords (`SecurePassword123!`, `SecurePassword456!`) with strong, unique passwords.
- Keep access keys secure and avoid sharing them.
