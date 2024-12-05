
# **Lab 13: Launching an EC2 Instance**

## **Objective**
- Create a VPC with both public and private subnets.
- Launch one EC2 instance in each subnet.
- Configure the security group of the private EC2 instance to only allow inbound SSH access from the public EC2 instance's IP.
- Use a bastion host (public EC2) to SSH into the private EC2 instance.

---

## **Steps**

### **1. Create a VPC**
1. Navigate to the **VPC** service in the AWS Management Console.
2. Create a new VPC with the desired CIDR block (e.g., `192.168.0.0/16`).
3. Create two subnets:
   - **Public Subnet**: Attach an internet gateway.
   - **Private Subnet**: No direct internet access.

---

### **2. Launch EC2 Instances**
1. **Public EC2 Instance**:
   - Place it in the **Public Subnet**.
   - Assign a public IP.
   - Attach a security group allowing inbound SSH from your local machine's IP.

2. **Private EC2 Instance**:
   - Place it in the **Private Subnet**.
   - Assign a security group that allows inbound SSH only from the public EC2 instance's IP.

---

### **3. Transfer Private Key to Public EC2**
1. Copy the private key file from your local machine to the public EC2 instance using `scp`:
   ```bash
   scp -i /path/to/your-key.pem /path/to/private-key.pem ec2-user@<PUBLIC_EC2_IP>:/home/ec2-user/
   ```

---

### **4. SSH to Public EC2**
1. Connect to the public EC2 instance using SSH:
   ```bash
   ssh -i /path/to/your-key.pem ec2-user@<PUBLIC_EC2_IP>
   ```

---

### **5. SSH to Private EC2 via Public EC2**
1. From the public EC2 instance, use the private key to connect to the private EC2 instance:
   ```bash
   ssh -i /path/to/private-key.pem ec2-user@<PRIVATE_EC2_IP>
   ```

---

## **Summary**
- The public EC2 instance acts as a bastion host to access the private EC2 instance.
- Security groups are configured to restrict SSH access to the private EC2 instance via the public EC2 instance only.

--- 


