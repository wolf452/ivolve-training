
# Kubernetes DaemonSet and Taint & Toleration Example

## Introduction
This project demonstrates the usage of Kubernetes DaemonSets, Taints, and Tolerations. It walks through creating a DaemonSet with Nginx containers, applying taints to nodes, and configuring tolerations to manage pod scheduling.

## Prerequisites
Before starting, ensure that you have the following:
- Minikube or a Kubernetes cluster up and running.
- `kubectl` installed and configured to interact with your cluster.

## Steps

### 1. Create a DaemonSet with Nginx Container

This step will create a DaemonSet that deploys an Nginx container on every node in the cluster.

Create a file `nginx-daemonset.yaml`:

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: nginx-daemonset
spec:
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
        image: nginx
        ports:
        - containerPort: 80
```

To apply the DaemonSet, run the following command:

```bash
kubectl apply -f nginx-daemonset.yaml
```

![apply pod](https://github.com/user-attachments/assets/3b497139-fa6c-4ba1-bdd4-1c9fa7aebb85)

After applying the DaemonSet, verify the number of pods created by running:

```bash
kubectl get pods -l app=nginx
```

![run](https://github.com/user-attachments/assets/ce9127e6-8d62-4844-a4da-0179982bccaa)

This should show an Nginx pod running on each node in your cluster.

### 2. Apply Taint to Minikube Node

Now, we'll add a taint to the Minikube node with the key-value pair `color=red`. This will prevent any pods from being scheduled on the node unless they have a matching toleration.

To add the taint, run the following command:

```bash
kubectl taint nodes minikube color=red:NoSchedule
```
![taint color red](https://github.com/user-attachments/assets/6fe9d7cc-2d33-46c5-b1a8-2d42136c0ae3)

You can verify the taint by running:

```bash
kubectl describe node minikube | grep Taints
```
![grep](https://github.com/user-attachments/assets/2295cfc8-c012-44cf-8ec0-db325ed61ea5)

### 3. Create a Pod with Toleration `color=blue`

Now, create a pod that has a toleration with the key `color=blue`. This pod should not be scheduled on the tainted node (`color=red`).

Create a file `toleration-pod.yaml`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: toleration-pod
spec:
  tolerations:
  - key: "color"
    operator: "Equal"
    value: "blue"
    effect: "NoSchedule"
  containers:
  - name: nginx
    image: nginx
```

To apply the pod, run:

```bash
kubectl apply -f toleration-pod.yaml
```
![fir](https://github.com/user-attachments/assets/03bca767-e068-476b-bd1b-ad1a49319af1)

Check the status of the pod:

```bash
kubectl get pods
```

The pod will remain in the **Pending** state because it cannot be scheduled on the tainted node.

### 4. Change Toleration to `color=red`

Now, modify the toleration in the `toleration-pod.yaml` file to match the taint (`color=red`).

Update the toleration in the YAML file:

```yaml
tolerations:
- key: "color"
  operator: "Equal"
  value: "red"
  effect: "NoSchedule"
```

Apply the updated pod configuration:

```bash
kubectl apply -f toleration-pod.yaml
```
![se](https://github.com/user-attachments/assets/a99483f9-872c-4b9c-9e01-d89ef4e2aa91)

Check the pod status:

```bash
kubectl get pods
```
![pending](https://github.com/user-attachments/assets/505c344f-d902-4ed5-80d5-f593c8c1d67a)

The pod should now be scheduled and running on the tainted node.

### 5. Comparison of Taint & Toleration and Node Affinity

- **Taint & Toleration**: Used to prevent pods from being scheduled on tainted nodes unless they have the matching **toleration**.
- **Node Affinity**: Used to control pod placement on nodes based on labels, offering more flexibility than taints and tolerations.

**Taint**: Prevents pods from being scheduled unless they have the matching **toleration**.

**Node Affinity**: Allows you to specify that a pod should be scheduled on nodes with certain labels, similar to how taints restrict pod placement but in a more declarative manner.

## Conclusion
This project demonstrates how to manage pod scheduling in Kubernetes using DaemonSets, Taints, and Tolerations. By using these concepts, you can control where pods are scheduled and ensure that your workloads are placed appropriately within your cluster.
