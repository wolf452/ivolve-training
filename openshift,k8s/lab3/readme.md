# Kubernetes Lab: NGINX Deployment with Persistent Volume

This lab demonstrates the process of creating a Kubernetes deployment with NGINX, configuring a persistent volume (PVC), and ensuring data persistence across pod deletions.

## Steps

### 1. Create a Deployment with NGINX
You can create the deployment directly using `kubectl` or by using a YAML file.

**Using kubectl:**
```bash
kubectl create deployment my-deployment --image=nginx --replicas=1
```
![createde](https://github.com/user-attachments/assets/f7f5f099-61d0-4e8f-baf6-a9e59796ba40)

### 2. Exec into the NGINX Pod and Create the File
/usr/share/nginx/html/hello.txt
First, find the name of the Pod
![creatingpod](https://github.com/user-attachments/assets/b9173915-4b94-4644-b9bd-85d782877021)
Then, exec into the Pod:
```bash
kubectl exec -it <nginx-pod-name> -- /bin/bash
```
![echo](https://github.com/user-attachments/assets/b79d05d3-6698-4a24-803e-ea7d983767af)



