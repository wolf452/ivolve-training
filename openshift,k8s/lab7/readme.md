
# Jenkins with Init Container, Readiness & Liveness Probes, and NodePort Service

## Overview

This document explains how to deploy a Jenkins application on Kubernetes with the following features:

1. **Init Container**: A container that runs before the main Jenkins container starts, ensuring initialization tasks (e.g., sleep for 10 seconds).
2. **Readiness & Liveness Probes**: These probes ensure the health of the application by checking whether it is ready to serve traffic and if it is alive.
3. **NodePort Service**: Exposes Jenkins to external traffic using a NodePort service type.

## Components

### 1. **Readiness and Liveness Probes**

- **Readiness Probe**: Determines if the application is ready to handle traffic. If the probe fails, Kubernetes will not send traffic to the application.
- **Liveness Probe**: Ensures the application is still alive. If the probe fails, Kubernetes will restart the container.

### 2. **Init Container and Sidecar Container**

- **Init Container**: Runs before the main container in a pod, typically used for setup tasks (e.g., waiting, downloading files). It runs sequentially; if it fails, the main container won’t start.
- **Sidecar Container**: Runs alongside the main container and provides auxiliary services like logging, monitoring, or data caching.

---

## Deployment YAML

### **1. Deployment for Jenkins with Init Container**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jenkins-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: jenkins
  template:
    metadata:
      labels:
        app: jenkins
    spec:
      initContainers:
      - name: init-container
        image: busybox
        command: ["sh", "-c", "echo 'Initializing...'; sleep 10"]
      containers:
      - name: jenkins
        image: jenkins/jenkins:lts
        ports:
        - containerPort: 8080
        - containerPort: 50000
        readinessProbe:
          httpGet:
            path: /login
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
        livenessProbe:
          httpGet:
            path: /login
            port: 8080
          initialDelaySeconds: 60
          periodSeconds: 20
```

### **2. Service Configuration for NodePort**

```yaml
apiVersion: v1
kind: Service
metadata:
  name: jenkins-service
spec:
  type: NodePort
  selector:
    app: jenkins
  ports:
  - port: 8080
    targetPort: 8080
    nodePort: 30080
```

---

## Steps to Apply the Configuration

1. **Save YAML Files**:
   - Save the Deployment YAML as `jenkins-deployment.yaml`.
   - Save the Service YAML as `jenkins-service.yaml`.

2. **Apply the Configuration**:
   Use the following commands to apply the YAML files to your Kubernetes cluster:

   ```bash
   kubectl apply -f jenkins-deployment.yaml
   kubectl apply -f jenkins-service.yaml
   ```
![app](https://github.com/user-attachments/assets/7057c507-8708-496e-a807-82a1c1841544)

3. **Verify the Status**:
   Check if the pods are running correctly:

   ```bash
   kubectl get pods
   ```
![running](https://github.com/user-attachments/assets/7fdfe9f8-abf9-41d3-b886-1c43aba65773)

Port Forwarding: Use the following command to forward port 8082 from your local machine to port 8080 in the Jenkins pod:

  ```bash

kubectl port-forward <jenkins-pod-name> 8082:8080
  ```
![port-forwaord](https://github.com/user-attachments/assets/eb158e8f-5800-4e8d-8fc1-67e27f39a1af)
![port](https://github.com/user-attachments/assets/b2759370-28b8-48f4-879f-9232b4220c44)


### Access Jenkins in the Browser**:
   Open your browser and go to:

   ```
   http://<Node-IP>:port
   ```
![fininsh](https://github.com/user-attachments/assets/81809290-020b-424e-8f61-3a01c8f9add3)



## Summary

- We deployed Jenkins with an **Init Container** to delay its startup for initialization.
- We configured **Readiness and Liveness Probes** to monitor the application's health.
- Jenkins is exposed externally via a **NodePort** service.

By following these steps, you can ensure that Jenkins is deployed in a Kubernetes environment with proper health checks and external accessibility.
