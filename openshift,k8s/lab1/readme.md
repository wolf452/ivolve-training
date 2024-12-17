# Kubernetes NGINX Deployment and Rollback Example

This README outlines the steps to deploy and manage a Kubernetes application using Minikube. In this example, we'll deploy NGINX with 3 replicas, expose the service, perform a deployment update to Apache, and then roll back to the previous version.

## Steps

### 1. Deploy ivolve with 3 Replicas
To deploy NGINX with 3 replicas, use the following command:

```bash
kubectl create deployment ivolve --image=nginx --replicas=3
```
![create deplo](https://github.com/user-attachments/assets/e0684431-07d9-4dfb-bb63-c0dfff25d33a)

![getpod](https://github.com/user-attachments/assets/e438cd8a-4ca6-456f-bba4-b0166abd91f6)


### 2.Expose the ivolve Deployment with a Service
Expose the NGINX deployment as a service to allow access:
```bash
kubectl expose deployment ivolve --port=80 --target-port=80 --name=nginx-service
```
![expose](https://github.com/user-attachments/assets/72807beb-6f0a-4a4c-ac33-f05eef32ba39)

### 3. Use Port Forwarding to Access ivolve Service Locally
Port forward the NGINX service to your local machine so you can access it:
```bash
kubectl port-forward svc/nginx-service 8081:80
```
You can now access the NGINX service at http://localhost:8081.
![portforword](https://github.com/user-attachments/assets/c1270c82-dc4e-4e27-b5af-43dcfcde5e1a)

### 6. Roll Back ivolve Deployment to the Previous Image Version
If you want to roll back the deployment to the previous version of the image, run:
```bash
kubectl rollout undo deployment/ivolve
```
![rollout](https://github.com/user-attachments/assets/3c9c3f81-3321-4571-a548-2161e5f49b1e)

### 7. Monitor Pod Status to Confirm Successful Rollback
To monitor the status of the pods and ensure that the rollback is successful, use:

```bash
kubectl get pods -w
```
