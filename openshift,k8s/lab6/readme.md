 MySQL Deployment with Kubernetes

This project demonstrates how to deploy a MySQL instance in Kubernetes using ConfigMap, Secret, and Resource Quotas. The setup includes creating a namespace, configuring resource limits, storing sensitive information like passwords securely, and verifying the setup.

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [ConfigMap and Secret Setup](#configmap-and-secret-setup)
- [Deployment Setup](#deployment-setup)
- [Verify the Deployment](#verify-the-deployment)
- [License](#license)

## Overview
In this guide, we will:
- Create a `namespace` called `ivolve`.
- Set a `ResourceQuota` to limit CPU and memory usage in the `ivolve` namespace.
- Create a MySQL deployment using `ConfigMap` and `Secret` for configuration and sensitive data like passwords.

## Prerequisites
Before starting, ensure that you have:
- A Kubernetes cluster up and running.
- `kubectl` command-line tool configured to interact with your cluster.
- Base64 encoding tool to encode passwords for Secrets.

## Installation

### 1. Create Namespace and Resource Quota
First, create a namespace and a resource quota for the `ivolve` namespace.

```yaml
# namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: ivolve
---
# resource-quota.yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: ivolve-quota
  namespace: ivolve
spec:
  hard:
    requests.cpu: "2"
    requests.memory: "4Gi"
    limits.cpu: "4"
    limits.memory: "8Gi"
```
Apply the file:
```bash
kubectl apply -f namespace.yaml
```
2. Create ConfigMap
The ConfigMap will hold the database name and user.

```yaml
# mysql-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-config
  namespace: ivolve
data:
  MYSQL_DATABASE: ivolve_db
  MYSQL_USER: ivolve_user
```
Apply the ConfigMap:
```bash
kubectl apply -f mysql-configmap.yaml
```
### 3. Create Secret
The Secret will store the root and user passwords in Base64 encoded form.
To create the Base64 encoded values for the passwords:
```bash
echo -n "user_root_password" | base64
echo -n "user_password" | base64
```
Then create the Secret.yaml:
```yaml
# mysql-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysql-secret
  namespace: ivolve
type: Opaque
data:
  MYSQL_ROOT_PASSWORD: dXNlcl9yb290X3Bhc3N3b3Jk # Base64-encoded root password
  MYSQL_PASSWORD: dXNlcl9wYXNzd29yZA==           # Base64-encoded user password
```
Apply the Secret:
```bash
kubectl apply -f mysql-secret.yaml
```

### 4. Create MySQL Deployment
Now create a MySQL deployment that uses the ConfigMap and Secret for configuration.

```yaml
# mysql-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
  namespace: ivolve
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:8.0
        ports:
        - containerPort: 3306
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: MYSQL_ROOT_PASSWORD
        - name: MYSQL_DATABASE
          valueFrom:
            configMapKeyRef:
              name: mysql-config
              key: MYSQL_DATABASE
        - name: MYSQL_USER
          valueFrom:
            configMapKeyRef:
              name: mysql-config
              key: MYSQL_USER
        - name: MYSQL_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: MYSQL_PASSWORD
        resources:
          requests:
            cpu: "500m"
            memory: "1Gi"
          limits:
            cpu: "1"
            memory: "2Gi"
```
Apply the MySQL deployment:

```bash
kubectl apply -f mysql-deployment.yaml
```
![files](https://github.com/user-attachments/assets/7b6ed891-084f-4d42-8372-7a0347567fa0)

### Verify the Deployment
1. Check Pod Status
Check if the MySQL pod is running:

```bash
kubectl get pods -n ivolve
```
![getpod](https://github.com/user-attachments/assets/9430caf5-c815-41e3-bf5d-d898cdd2b8f9)

2. Access MySQL Pod
Access the MySQL pod to verify the configuration:

```bash
kubectl exec -it <mysql-pod-name> -n ivolve -- bash
mysql -u ivolve_user -p
```
![exec](https://github.com/user-attachments/assets/ded93765-c948-456d-979a-bd41c43e8179)

When prompted, enter the password (e.g., myivolve for ivolve_user).

3. Check Databases
Once inside MySQL, you can check the databases:

```sql
SHOW DATABASES;
```
![finish](https://github.com/user-attachments/assets/1eedcdbe-a06e-4283-ae70-1adf535d55ed)
