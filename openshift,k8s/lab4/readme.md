# OpenShift Security and RBAC

## Overview

In Kubernetes and OpenShift, **RBAC** (Role-Based Access Control) is used to control access to resources. This guide explains how to create a **ServiceAccount**, define a **Role** with read-only access to pods in a namespace, bind the role to the service account, and compare the concepts of **Role & RoleBinding** with **ClusterRole & ClusterRoleBinding**.

## Steps

### 1. Create a ServiceAccount

A **ServiceAccount** provides an identity for processes running in a Pod. ServiceAccounts are used to control access to resources in a Kubernetes cluster.

To create a ServiceAccount, run:

```bash
kubectl create serviceaccount my-service-account
```

# OpenShift Security and RBAC

## Overview

In Kubernetes and OpenShift, **RBAC** (Role-Based Access Control) is used to control access to resources. This guide explains how to create a **ServiceAccount**, define a **Role** with read-only access to pods in a namespace, bind the role to the service account, and compare the concepts of **Role & RoleBinding** with **ClusterRole & ClusterRoleBinding**.

## Steps

### 1. Create a ServiceAccount

A **ServiceAccount** provides an identity for processes running in a Pod. ServiceAccounts are used to control access to resources in a Kubernetes cluster.

To create a ServiceAccount, run:

```bash
kubectl create serviceaccount my-service-account
This will create a ServiceAccount named my-service-account.
```
### 2. Define a Role Named pod-reader
A Role defines the permissions available within a namespace. For this example, we will create a role that provides read-only access to the pods in the default namespace.

Create a file named pod-reader-role.yaml:
yaml
Copy code
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list"]
Apply the role with:

```bash
kubectl apply -f pod-reader-role.yaml
```
This role allows reading (getting and listing) pods in the default namespace

### 3. Bind the pod-reader Role to the ServiceAccount
Next, we will create a RoleBinding to associate the pod-reader role with the ServiceAccount my-service-account.

Create a file named pod-reader-binding.yaml:

yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: pod-reader-binding
  namespace: default
subjects:
- kind: ServiceAccount
  name: my-service-account
  namespace: default
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
Apply the role binding with:

```bash

kubectl apply -f pod-reader-binding.yaml
```
This binds the pod-reader role to the my-service-account ServiceAccount in the default namespace.


### 4. Get the ServiceAccount Token
Once the ServiceAccount is created, you can get the token associated with it for authentication:

```bash
kubectl get secret $(kubectl get serviceaccount my-service-account -o jsonpath='{.secrets[0].name}') -o jsonpath='{.data.token}' | base64 --decode
```
This command retrieves the token for the ServiceAccount my-service-account.

### 5. Comparison Between Role & RoleBinding and ClusterRole & ClusterRoleBinding
    Role & RoleBinding:

A Role defines a set of permissions within a specific namespace.
A RoleBinding grants the permissions defined in the Role to a user, group, or ServiceAccount within that namespace.
These are used for managing permissions within a single namespace.
ClusterRole & ClusterRoleBinding:

A ClusterRole defines a set of permissions at the cluster level and can apply to all namespaces.
A ClusterRoleBinding grants the permissions defined in the ClusterRole to a user, group, or ServiceAccount across the entire cluster.
These are used for cluster-wide permission
