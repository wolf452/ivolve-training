# Static Website Deployment on Kubernetes
This guide provides instructions to deploy a static website using Docker, Kubernetes, and Minikube, including network configurations.

## Steps
### 1. Network Configuration
Build a new image from the Dockerfile
To build the Docker image from the Dockerfile in the repository:

Clone the repository:

```bash

git clone https://github.com/IbrahimmAdel/static-website.git
cd static-website
```
Build the Docker image:
```bash
docker build -t static-website:latest .
```
![build](https://github.com/user-attachments/assets/479ec38c-ec48-4866-b025-d8855532fe72)

### 2. Create a Deployment using this image
To ceate a Kubernetes deployment using the image you just built:

Create a deployment.yaml file:

```yaml
Copy code
apiVersion: apps/v1
kind: Deployment
metadata:
  name: static-website
spec:
  replicas: 2
  selector:
    matchLabels:
      app: static-website
  template:
    metadata:
      labels:
        app: static-website
    spec:
      containers:
      - name: nginx
        image: static-website:latest
        ports:
        - containerPort: 80
```
Apply the deployment configuration:

```bash
kubectl apply -f deployment.yaml
```
![applydeploy](https://github.com/user-attachments/assets/5556fcf1-111a-41ea-9b23-9b5f94790289)

Create a Service to Expose the Deployment
To expose the deployment and provide internal access:

### 3. Create a service.yaml file:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: static-website-service
spec:
  selector:
    app: static-website
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: ClusterIP
```
Apply the service configuration:

```bash
kubectl apply -f service.yaml
```
or
![expose](https://github.com/user-attachments/assets/cf491017-4e0c-4b7b-b1c2-adf03c546ffa)

### 4. Define a Network Policy to Allow Traffic Only from the Same Namespace
To restrict traffic to the static-website pods only from other pods within the same namespace:

Create a network-policy.yaml file:
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-same-namespace
spec:
  podSelector:
    matchLabels:
      app: static-website
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector: {}
```
Apply the network policy configuration:

```bash
kubectl apply -f network-policy.yaml
```

Enable the NGINX Ingress Controller Using Minikube
Minikube includes an addon for enabling the NGINX Ingress Controller. Enable it to expose services externally:

Enable the Ingress addon:

```bash
minikube addons enable ingress
```
![applydeploy](https://github.com/user-attachments/assets/f6e247fc-d058-4d3f-94d8-6dc83c6062e2)

Create an Ingress Resource
To expose the static-website-service via an Ingress resource:

### 5. Create an ingress.yaml file:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: static-website-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: static-website.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: static-website-service
            port:
              number: 80
```
Apply the ingress configuration:

```bash
kubectl apply -f ingress.yaml
```
### 6. Update the /etc/hosts File
To access the service using the domain static-website.local, update the /etc/hosts file:
![hosts](https://github.com/user-attachments/assets/b38e0547-15d9-413e-b6fb-18e4697085ee)

Get the Minikube IP address:

```bash

minikube ip
```
(Assume the IP is 192.168.49.2)
![ip+applyingre](https://github.com/user-attachments/assets/2af00dcb-082a-4789-9d01-779b70f898b0)

### 7. Open the /etc/hosts file and add the following entry:

```text

192.168.49.2 static-website.local
```
Access the Custom NGINX Service
After updating the /etc/hosts file, you can access the static website via the Ingress endpoint using the domain static-website.local.

Open a browser and go to:

```vbnet

http://static-website.local
```
![fininsh](https://github.com/user-attachments/assets/63896bf0-73d8-4b2d-815a-984005646eb7)



