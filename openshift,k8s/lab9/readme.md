# Nginx Helm Chart Deployment

## 1. Introduction

This repository contains a Helm chart to deploy Nginx on Kubernetes.

## 2. Prerequisites

Before you start, make sure you have the following installed on your machine:
- [Helm](https://helm.sh/docs/intro/install/) (Helm version 3+)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- A running Kubernetes cluster (e.g., Minikube, Docker Desktop, GKE, etc.)

## 3. Creating a Helm Chart for Nginx

To create the Helm chart for Nginx:

1. **Create a new Helm chart**:
   ```bash
   helm create nginx-chart
```
![crear](https://github.com/user-attachments/assets/f7c75505-070a-4626-908d-2c357c925e66)

### 2.Navigate to the Helm chart directory:

bash
Copy code
cd nginx-chart
(Optional) Customize values.yaml: Modify the values.yaml file to customize Nginx settings, such as the port or image configuration. For example:

yaml
Copy code
service:
  port: 80
(Optional) Edit deployment.yaml: If needed, make further customizations in templates/deployment.yaml for Nginx deployment.
