# Jenkins Shared Library Setup

## Objective
The goal of this repository is to implement Jenkins Shared Libraries to reuse code across multiple Jenkins pipelines. This approach allows common tasks, such as building Docker images, deploying to Kubernetes, and checking deployment statuses, to be centralized in one shared library and reused in different pipelines.

By using shared libraries, you avoid redundancy and simplify pipeline maintenance across your Jenkins environment.

## Libraries Overview
This repository includes the following Groovy libraries, which are meant to be used in different Jenkins pipelines:

### 1. `deploymentLib.groovy`
Provides a function to edit Kubernetes deployment YAML files with the Docker image name.

- **`editDeploymentYaml(String yamlFile, String dockerImage)`**: Replaces the `image` field in the specified YAML file with the provided Docker image.

### 2. `dockerLib.groovy`
Provides functions to build and push Docker images.

- **`buildImage(String imageName)`**: Builds a Docker image with the provided name.
- **`pushImage(String imageName, String credentialsId)`**: Pushes the Docker image to a Docker registry using credentials stored in Jenkins.

### 3. `gitLib.groovy`
Provides a function to check out a Git repository.

- **`checkoutRepository(String repoUrl, String branch = 'main', String subDir = '')`**: Checks out the specified repository and branch, optionally into a subdirectory.

### 4. `kubernetesLib.groovy`
Provides functions to deploy to a Kubernetes cluster and check the status of the deployment.

- **`deployToKubernetes(String kubeConfigPath, String token, String yamlFile, String namespace)`**: Deploys the given YAML file to a Kubernetes cluster using the provided Kubernetes configuration and token.
- **`checkDeploymentStatus(String kubeConfigPath, String token, String deploymentName, String namespace)`**: Checks the status of the specified deployment in the given namespace. If the deployment is not available, an error is thrown.

## Setup Instructions

### 1. Set Up Jenkins
Ensure that Jenkins is installed and configured on your system.

### 2. Install Pipeline Utility Plugins
- Go to **Manage Jenkins** > **Manage Plugins**.
- Install the following plugin:
  - **Pipeline: Shared Groovy Libraries**

### 3. Set Up the Shared Library in Jenkins
1. Create a repository for your shared libraries.
2. Go to **Jenkins Dashboard** > **Manage Jenkins** > **Configure System**.
3. Scroll to the **Global Pipeline Libraries** section.
4. Add a new library:
   - **Name**: `common-library`
   - **Default Version**: `main`
   - **Retrieval Method**: **Modern SCM**
   - **SCM**: **Git** (Provide your repository URL)

### 4. Add Credentials in Jenkins
You will need to add the following credentials in Jenkins:
- Docker credentials for Docker login and push.
- Kubernetes credentials for accessing the cluster.
  - Add a **SecretFile** for the Kubernetes token.

### 5. Folder Structure
Ensure the following folder structure for your shared library:

jenkins/lab2/shared-library-name/ ├── vars/ │ ├── deploymentLib.groovy │ ├── dockerLib.groovy │ ├── gitLib.groovy │ └── kubernetesLib.groovy

python
Copy code

### 6. Example Usage

You can now use the shared libraries in your Jenkins pipelines to simplify and automate tasks like building Docker images, deploying to Kubernetes, and checking the status of your deployments.

#### Example pipeline 1: **Build and Deploy Pipeline**

```groovy
@Library('common-library') _
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkoutRepository('https://github.com/your/repo.git')
            }
        }
        stage('Build Docker Image') {
            steps {
                buildImage('your-image-name')
            }
        }
        stage('Push Docker Image') {
            steps {
                pushImage('your-image-name', 'docker-credentials-id')
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                deployToKubernetes('/path/to/kubeconfig', 'your-k8s-token', 'deployment.yaml', 'namespace')
            }
        }
        stage('Check Deployment Status') {
            steps {
                checkDeploymentStatus('/path/to/kubeconfig', 'your-k8s-token', 'your-deployment-name', 'namespace')
            }
        }
    }
}
Example pipeline 2: Build, Test, and Deploy Pipeline
groovy
Copy code
@Library('common-library') _
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkoutRepository('https://github.com/your/repo.git')
            }
        }
        stage('Build Docker Image') {
            steps {
                buildImage('your-image-name')
            }
        }
        stage('Run Tests') {
            steps {
                // Add testing steps here
                echo 'Running tests...'
            }
        }
        stage('Push Docker Image') {
            steps {
                pushImage('your-image-name', 'docker-credentials-id')
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                deployToKubernetes('/path/to/kubeconfig', 'your-k8s-token', 'deployment.yaml', 'namespace')
            }
        }
        stage('Check Deployment Status') {
            steps {
                checkDeploymentStatus('/path/to/kubeconfig', 'your-k8s-token', 'your-deployment-name', 'namespace')
            }
        }
    }
}
Additional Notes
Replace the placeholders (like your-image-name, docker-credentials-id, etc.) with your actual values.
Make sure the Kubernetes token and Docker credentials are correctly set in Jenkins.
![cerditi](https://github.com/user-attachments/assets/b04eb22d-e1ae-4697-a2c9-1bc674099a41)

Benefits of Shared Libraries
By implementing shared libraries in Jenkins:

You can reuse code across multiple pipelines, reducing duplication and improving maintainability.
You can centralize common tasks like Docker builds, deployments, and repository checkouts into one library.
You can manage changes in one place, which will automatically be reflected in all pipelines that use the shared library.
This setup enables you to efficiently use common deployment steps across multiple Jenkins pipelines, improving the overall consistency and efficiency of your CI/CD process.

![fininsh](https://github.com/user-attachments/assets/f0e2e418-f9dc-42d7-ae46-90980e6a6165)
![load](https://github.com/user-attachments/assets/5ee924c2-6646-457d-968c-fd034c486ed3)
![finish2](https://github.com/user-attachments/assets/8605d4ea-4fe9-46f4-aaaf-1aa7b98449c1)

