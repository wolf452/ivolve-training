
# **Lab 14: Create AWS Load Balancer**

## **Objective**
- Create a VPC with 2 public subnets.
- Launch 2 EC2 instances with Nginx and Apache installed using user data.
- Create and configure a Load Balancer to distribute traffic between the two web servers.

---

## **Steps**

### **1. Create a VPC with Public Subnets**
1. Navigate to the **VPC** service in the AWS Management Console.
2. Create a new VPC with a CIDR block (e.g., `10.0.0.0/16`).
3. Create two subnets:
   - Assign them to different availability zones.
   - Attach an **Internet Gateway (IGW)** to the VPC.
   - Update the route table for both subnets to include a route to the IGW, making them public.

---

### **2. Launch EC2 Instances**
1. Launch two EC2 instances in the public subnets:
   - **Instance 1**: Install Nginx using user data.
   - **Instance 2**: Install Apache using user data.

   **Sample User Data for Nginx:**
   ```bash
   #!/bin/bash
   yum update -y
   amazon-linux-extras install nginx1 -y
   systemctl start nginx
   systemctl enable nginx
   echo "<h1>Nginx Server</h1>" > /usr/share/nginx/html/index.html
   ```

   **Sample User Data for Apache:**
   ```bash
   #!/bin/bash
   yum update -y
   yum install httpd -y
   systemctl start httpd
   systemctl enable httpd
   echo "<h1>Apache Server</h1>" > /var/www/html/index.html
   ```

---

### **3. Configure Security Groups**
1. For EC2 instances:
   - Allow **HTTP** (port 80) traffic from the Load Balancer security group.
   - Allow **SSH** (port 22) traffic from your local machine’s IP.
2. For the Load Balancer:
   - Allow all traffic (port 80) with the source set to `0.0.0.0/0`.

---

### **4. Create and Configure a Load Balancer**
1. Navigate to the **Load Balancers** section in the EC2 Management Console.
2. Choose the **Application Load Balancer** type.
3. Select the VPC and both public subnets for the Load Balancer.
4. Configure listeners:
   - Listener Protocol: **HTTP**
   - Listener Port: **80**
5. Configure security groups:
   - Use the Load Balancer security group created earlier.

---

### **5. Create a Target Group**
1. In the Load Balancer configuration, create a target group:
   - Target Type: **Instances**
   - Protocol: **HTTP**
   - Port: **80**
2. Register the EC2 instances to the target group.

---

### **6. Configure Health Checks**
1. Define a health check for the target group:
   - Protocol: **HTTP**
   - Path: `/`
   - Port: **80**
   - Set thresholds for healthy/unhealthy checks (e.g., 2 consecutive successes for healthy).

---

## **Output**
- The Load Balancer will distribute traffic between the two EC2 instances.
- Access the Load Balancer DNS name to verify the setup:
  - You should see either the Nginx or Apache web page on refresh, depending on which instance handles the request.

--- 
