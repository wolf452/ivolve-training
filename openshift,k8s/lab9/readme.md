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
![crear](https://github.com/user-attachments/assets/2934a6e4-ffac-4e90-8cc3-f35853079757)

### 2.Navigate to the Helm chart directory:

 ```bash

cd nginx-chart
 ```
(Optional) Customize values.yaml: Modify the values.yaml file to customize Nginx settings, such as the port or image configuration. For example:

 ```yaml

service:
  port: 80
 ```
![vim](https://github.com/user-attachments/assets/0c50e0e7-bb67-4684-a06e-1ed8a36c48ad)

(Optional) Edit deployment.yaml: If needed, make further customizations in templates/deployment.yaml for Nginx deployment.

### To deploy the Nginx Helm chart to your Kubernetes cluster, run the following command:

 ```bash
helm install nginx-release ./nginx-chart
 ```
![install](https://github.com/user-attachments/assets/f9c8b6b3-04d6-43df-9914-f6472586e889)

This will create a Helm release named nginx-release.

### 5. Verify the Nginx Deployment
To check the status of the Nginx deployment, use the following command:

 ```bash

kubectl get pods
 ```
![get](https://github.com/user-attachments/assets/e9a4f092-5f24-40dc-b832-dec1b5428cc7)


Ensure the Nginx pod is running correctly.

### 6. Access the Nginx Server
You can access the Nginx server in the following ways:

For Minikube:

 ```bash

minikube service nginx-release
 ```

![svt](https://github.com/user-attachments/assets/39eb089d-99bb-4d44-9ac4-bbe6e7670fd2)
![svr](https://github.com/user-attachments/assets/7adc6a52-e495-4aa2-8f7c-6a19e07f4a90)

For kubectl port-forward:

 ```bash

kubectl port-forward svc/nginx-release 8080:80
 ```
![forward](https://github.com/user-attachments/assets/d9c5812f-bbd8-42c3-b38a-25b03108a3d4)

After running the above commands, access Nginx via http://localhost:8080 in your browse
![welc](https://github.com/user-attachments/assets/d909e9bb-8ee4-4370-a09d-6d40b52eac03)

