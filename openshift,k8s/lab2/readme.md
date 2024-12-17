
# Kubernetes StatefulSet with MySQL

This document explains how to set up a **StatefulSet** with **MySQL** on Kubernetes, along with a **Service** to ensure access to the Pods derived from the StatefulSet. This setup is mainly used for applications that require persistent storage, such as databases.

## 1. **System Requirements**
- **Kubernetes Cluster**: Ensure you have a Kubernetes cluster running (e.g., Minikube, OpenShift, or any other Kubernetes cluster).
- **kubectl**: The Kubernetes command-line tool should be installed and configured to work with your cluster.
- **MySQL Docker Image**: We will be using the MySQL Docker image for this setup.

## 2. **Setting Up StatefulSet with MySQL**

### Objective:
Create a **StatefulSet** with 3 replicas to run MySQL, using **Persistent Volumes** to keep data even if Pods are restarted or rescheduled.

### File: `mysql-statefulset.yaml`

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql
spec:
  serviceName: "mysql"
  replicas: 3
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
        image: mysql:5.7
        ports:
        - containerPort: 3306
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: "rootpassword"
        volumeMounts:
        - name: mysql-data
          mountPath: /var/lib/mysql
  volumeClaimTemplates:
  - metadata:
      name: mysql-data
    spec:
      accessModes: 
        - ReadWriteOnce
      resources:
        requests:
          storage: 1Gi
```

### Explanation:
- **replicas: 3**: This creates 3 replicas (Pods) of the MySQL service.
- **PersistentVolumeClaim (PVC)**: `volumeClaimTemplates` is used to ensure persistent storage for each Pod.
- **MySQL Root Password**: The root password for MySQL is set to `rootpassword` via an environment variable.

### Apply the StatefulSet:

```bash
kubectl apply -f mysql-statefulset.yaml
```
![app1](https://github.com/user-attachments/assets/51299a74-41d5-43ba-8171-8361fae5d56e)


## 3. **Creating a Service for MySQL**

### Objective:
Create a **Service** to expose MySQL to other applications within the Kubernetes cluster. The service will route traffic to the Pods created by the StatefulSet.

### File: `mysql-service.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mysql
spec:
  clusterIP: None
  selector:
    app: mysql
  ports:
    - port: 3306
      targetPort: 3306
```

### Explanation:
- **clusterIP: None**: This makes the service "Headless," meaning that it routes traffic to individual Pods directly using their stable names, like `mysql-0.mysql`, `mysql-1.mysql`, etc.
- **port: 3306**: The port used to access MySQL inside the Pods.

### Apply the Service:

```bash
kubectl apply -f mysql-service.yaml
```
![app2](https://github.com/user-attachments/assets/d0482f02-a90f-4c09-b279-f4ccc3270922)

## 4. **Verification**

After applying the files, you can check the status of the StatefulSet and Service using the following commands:

### Verify the StatefulSet:

```bash
kubectl get statefulset
```
![get-sat](https://github.com/user-attachments/assets/3a287047-acc6-427b-9a2e-befe44ea9aa2)

This will show a list of StatefulSets in your cluster. Ensure that `mysql` is listed.

### Verify the Pods:

```bash
kubectl get pods
```

This will show a list of Pods. Make sure the Pods with names like `mysql-0`, `mysql-1`, etc., are running.

### Verify the Service:

```bash
kubectl get service mysql
```
![get-pod](https://github.com/user-attachments/assets/ffb63355-03d9-4f26-9b18-9250318630ae)

This will show details of the service, including the ClusterIP and the ports it exposes.

### Verify the PersistentVolumeClaims (PVC):

```bash
kubectl get pvc
```
![get pv](https://github.com/user-attachments/assets/39901a51-d1e4-4168-a17b-da86b797a950)

This will show the PVCs associated with the StatefulSet.


### Delete the StatefulSet:

```bash
kubectl delete statefulset mysql
```

### Delete the Service:

```bash
kubectl delete service mysql
```

### Delete the PVC:

```bash
kubectl delete pvc -l app=mysql
```
![delete](https://github.com/user-attachments/assets/069c065b-94ea-4903-ab7f-c09c935aadd3)


## 7. **Deployment vs. StatefulSet**

### **Deployment**
- **Purpose**: Used for managing stateless applications that do not require persistent storage or stable network identities.
- **Storage**: Does not guarantee persistent storage.
- **Identity**: Pods have random names and do not retain state or stable identities after restarts.
- **Scaling**: Easily scale up or down by adjusting the number of replicas.
- **Use Case**: Suitable for stateless applications like web servers or processing applications.

### **StatefulSet**
- **Purpose**: Used for managing stateful applications that need persistent storage and stable network identities.
- **Storage**: Guarantees persistent storage via Persistent Volumes, ensuring data is retained even after Pod restarts.
- **Identity**: Pods are assigned stable identities with names like `mysql-0`, `mysql-1`, etc., and retain their state.
- **Scaling**: Pods are scaled in a specific order, preserving their identity (e.g., `mysql-0`, `mysql-1`).
- **Use Case**: Suitable for stateful applications like databases or applications requiring stable network identities.

## 8. **Notes**

- Ensure that you are using a Kubernetes version that supports StatefulSets.
- StatefulSets are useful for applications that require persistent storage and stable network identities, such as databases.
- The Service allows traffic to be directed to the Pods based on their stable names.
- Scaling a StatefulSet keeps the order of Pods intact.
