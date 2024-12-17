# Lab 26: MultiBranch Pipeline Project

This repository demonstrates how to set up a **Jenkins CI/CD Pipeline** integrated with **GitHub Webhook**, **ngrok** for external access, and **Java 17** to manage the deployment in Kubernetes namespaces.

## Project Objectives
1. **Create 3 namespaces in Kubernetes**: `dev`, `test`, and `prod`.
2. **Set up Jenkins** to integrate with GitHub and automatically trigger builds using webhooks.
3. **Use ngrok** to expose Jenkins to GitHub for webhook communication.
4. **Install Java 17** on Jenkins for running builds.
5. **Deploy Jenkins Slave** in different namespaces (`dev`, `test`, or `prod`) to run specific jobs for each environment.

## Prerequisites
Before starting the setup, ensure you have the following:
1. **Jenkins** instance running locally or on a server.
2. **GitHub** repository to integrate with Jenkins.
3. **ngrok** installed to generate a public URL for Jenkins to receive webhooks from GitHub.
4. **Java 17** installed on Jenkins for running builds.
5. **Kubernetes** cluster with the ability to create and manage namespaces (`dev`, `test`, and `prod`).

## Step-by-Step Setup

### 1. Set up Kubernetes namespaces
To create the necessary namespaces in your Kubernetes cluster for different environments (`dev`, `test`, `prod`), use the following commands:

```bash
kubectl create namespace dev
kubectl create namespace test
kubectl create namespace prod
```
 ### Install ngrok
Install ngrok on the machine where Jenkins is running. To do this, run:

```bash

sudo apt install ngrok
```
![install package](https://github.com/user-attachments/assets/8eb88f36-96e0-4854-b03c-92589fabf01a)


3. Run ngrok
Start ngrok to create a public endpoint that will forward traffic to Jenkins (default port 8080):

```bash

ngrok http 8080
This will give you a public URL (e.g., http://random-id.ngrok.io). Copy this URL, as it will be used to configure the GitHub webhook.
and can use public ip with port
```

###  Configure Webhook in GitHub
Go to your GitHub repository:
Navigate to Settings → Webhooks → Add webhook.
In the Payload URL, paste the ngrok URL followed by /github-webhook. For example:
```bash

http://random-id.ngrok.io/github-webhook
```
Set Content type to application/json.
Select Just the push event to trigger Jenkins builds on GitHub push events.

![web](https://github.com/user-attachments/assets/64b10e54-e685-4940-b858-512cf0dc3192)

![finish webhook](https://github.com/user-attachments/assets/2861ee16-aede-4c44-9737-9ef56f6202e0)

# in jenkins-slave
Before starting the setup, ensure you have the following:

1. **Jenkins Master** running.
2. **Jenkins Slave** machine (with SSH access).
3. **Java 17** installed on the Jenkins Slave.
4. **Docker** installed on the Jenkins Slave.
5. **Minikube** installed and configured on the Jenkins Slave.
6. **Kubectl** installed to interact with the Kubernetes cluster.

## Step-by-Step Setup

### 1. Set Up Jenkins Master-Slave Architecture

#### Configure the Jenkins Master:
1. Install Jenkins on the master node.
2. Go to `Manage Jenkins → Manage Nodes`.
3. Click on **New Node**, choose **Permanent Agent**, and give it a name (e.g., `slave-node`).
4. Configure the following details:
   - **Remote root directory**: Path where Jenkins will store files on the slave.
   - **Launch method**: Select **Launch agents via SSH**.
   - **Host**: The IP address or hostname of the slave machine.
   - **Credentials**: Provide the SSH credentials for the slave node.

#### Configure the Jenkins Slave:
1. On the slave machine, ensure you have **SSH** access set up.
2. The Jenkins slave will automatically connect to the master using the provided SSH credentials.

### 2. Install Java 17 on Jenkins Slave

On the Jenkins Slave machine, run the following command to install Java 17:

```bash
sudo apt update
sudo apt install openjdk-17-jdk
```
![slave](https://github.com/user-attachments/assets/aba9d267-c7fb-4e18-8bde-2764af7a5d5a)
### Install Docker on Jenkins Slave
To install Docker on the Jenkins Slave machine, run the following commands:

```bash
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce
```
Verify the Docker installation with:

```bash

docker --version
```
Make sure the Jenkins Slave has permission to run Docker without sudo. Add the Jenkins user to the Docker group:

```bash

sudo usermod -aG docker jenkins
```
Then, restart the Jenkins service.
### Install Minikube on Jenkins Slave
To install Minikube on the Jenkins Slave machine, follow these steps:

Install Minikube by running the following commands:
```bash
Copy code
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin
Start Minikube to create a local Kubernetes cluster:
```
```bash

minikube start
```
### 5. Install Kubectl on Jenkins Slave
To install Kubectl on the Jenkins Slave, run the following commands:

```bash

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin
```
Verify the Kubectl installation:

```bash

kubectl version --client
```
