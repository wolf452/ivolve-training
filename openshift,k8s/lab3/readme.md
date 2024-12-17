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


### 4. 4. Delete the NGINX Pod and Verify a New Pod is Created
To delete the Pod:

 ```bash
  kubectl delete pod <nginx-pod-name>
 ```
 Verify that Kubernetes creates a new Pod:

```bash
kubectl get pods
```
![replic](https://github.com/user-attachments/assets/34f9e099-b9d0-4a1a-b0bf-aac4daff2ea4)

### 5. Exec into the New Pod and Verify the File is No Longer Present
Exec into the new Pod:

```bash

kubectl exec -it <new-nginx-pod-name> -- /bin/bash
```
Check if the file is missing:

```bash

ls /usr/share/nginx/html/
```
The file should not be present as it was only stored in the Pod and was not persistent.
![notfiel](https://github.com/user-attachments/assets/937c23dc-59bb-4d8f-9810-9d0b9b4dfd30)


### 6. Create a PVC and Modify the Deployment to Attach the PVC
First, create a Persistent Volume Claim (PVC) using the following YAML file (nginx-pvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nginx-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
Apply the PVC:
```bash
kubectl apply -f nginx-pvc.yaml
```

![2dep](https://github.com/user-attachments/assets/62bbc044-45a4-4c0a-a08c-84e2b6531b18)
Now, modify the Deployment to attach the PVC to the /usr/share/nginx/html directory in the Pod using this YAML (nginx-deployment-with-pvc.yaml):
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
        volumeMounts:
        - name: nginx-storage
          mountPath: /usr/share/nginx/html
      volumes:
      - name: nginx-storage
        persistentVolumeClaim:
          claimName: nginx-pvc
Apply the modified Deployment:
```bash
kubectl apply -f nginx-deployment-with-pvc.yaml
```
Exec into the new Pod and verify that the hello.txt file still exists.

![fini](https://github.com/user-attachments/assets/ed88f657-5876-4d65-b39f-c71bc4894676)

