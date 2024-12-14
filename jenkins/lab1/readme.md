
# Jenkins Pipeline for Application Deployment

This repository contains a Jenkins pipeline for automating the deployment of a Dockerized application to a Kubernetes (K8s) cluster. The pipeline will:

1. **Build a Docker image** from the Dockerfile in the GitHub repository.
2. **Push the Docker image** to Docker Hub.
3. **Update the `deployment.yaml` file** with the new Docker image.
4. **Deploy the application to Kubernetes**.
5. **Post-action** to notify successful deployment.

## Prerequisites

Ensure you have the following prerequisites before using this Jenkins pipeline:

- **Jenkins** installed and configured.
- **Docker** installed on the Jenkins agent.
- **Kubernetes** cluster up and running, with `kubectl` configured.
- **Docker Hub** credentials stored in Jenkins under the ID `Docker_hub`.
- **Kubernetes Token** stored in Jenkins under the ID `k8s_token`.

## Jenkins Pipeline Overview

### 1. Checkout Code

The pipeline first checks out the code from two GitHub repositories:

- **Main repository**: `https://github.com/IbrahimAdell/Lab.git`
- **Secondary repository** for Docker image files: `https://github.com/wolf8534/ivolve-.git`

### 2. Build Docker Image

In this stage, the pipeline builds a Docker image using the Dockerfile located in the repository.

```groovy
stage('Build Docker Image') {
    steps {
        script {
            sh 'docker build -t $DOCKER_IMAGE .'
        }
    }
}
```

### 3. Push Docker Image to Docker Hub

After the image is built, it is pushed to Docker Hub using credentials stored in Jenkins.

```groovy
stage('Push Docker Image') {
    steps {
        script {
            withCredentials([usernamePassword(credentialsId: 'Docker_hub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                sh 'docker push $DOCKER_IMAGE'
            }
        }
    }
}
```

### 4. Update `deployment.yaml`

This stage updates the `deployment.yaml` file to reflect the new Docker image.

```groovy
stage('Edit Deployment.yaml') {
    steps {
        script {
            sh "sed -i 's|image:.*|image: $DOCKER_IMAGE|g' $DEPLOYMENT_YAML"
        }
    }
}
```

### 5. Deploy to Kubernetes

The updated `deployment.yaml` file is then applied to the Kubernetes cluster.

```groovy
stage('Deploy to Kubernetes') {
    steps {
        script {
            withCredentials([string(credentialsId: 'k8s_token', variable: 'K8S_TOKEN')]) {
                sh '''
                kubectl --kubeconfig=/home/jenkins/.kube/config --token=$K8S_TOKEN apply -f $DEPLOYMENT_YAML -n $KUBE_NAMESPACE
                '''
            }
        }
    }
}
```

### 6. Post Action

Once the deployment is complete, a success message is printed.

```groovy
stage('Post Action') {
    steps {
        script {
            echo "Deployment to Kubernetes completed successfully!"
        }
    }
}
```

### 7. Post Pipeline Actions

The pipeline includes actions for success and failure:

```groovy
post {
    success {
        echo "Pipeline executed successfully."
    }
    failure {
        echo "Pipeline failed."
    }
}
```

## Kubernetes Configuration

You need to configure Kubernetes RBAC roles, bindings, and a service account for the Jenkins user. Below are the necessary configuration files:

### Role Configuration (`role.yaml`)

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: jenkins-role
rules:
  - apiGroups: [""]
    resources: ["pods", "services", "deployments"]
    verbs: ["get", "list", "create", "update", "delete"]
```
### Role Binding Configuration (`rolebinding.yaml`)

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: jenkins-rolebinding
  namespace: default
subjects:
  - kind: ServiceAccount
    name: jenkins
    namespace: default
roleRef:
  kind: Role
  name: jenkins-role
  apiGroup: rbac.authorization.k8s.io
```

### Service Account Configuration (`serviceaccount.yaml`)

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: jenkins
  namespace: default
```

### Create Required Ceredentials
2.1 Create Jenkins Credentials :

Manage Jenkins >> Credentials >> Add Credentials

![cred](https://github.com/user-attachments/assets/fbdd2bfa-6c77-4d08-8ef8-7b95d3d073b9)

### Check the Jenkins file in the git repo and other related files the run the build
Verify the Execution of the Pipeline
kubectl get deployments
image
### Finish
![finish2](https://github.com/user-attachments/assets/89773c32-3719-49dc-b133-7bfd8dae70cf)
![finish](https://github.com/user-attachments/assets/08752853-1da4-474f-9bf8-c9681f4fc352)

## Conclusion

This Jenkins pipeline automates the entire process of building a Docker image, pushing it to Docker Hub, updating a Kubernetes deployment, and deploying it to a Kubernetes cluster. Make sure the necessary RBAC roles and bindings are configured to grant the Jenkins user the required permissions to interact with Kubernetes resources.
