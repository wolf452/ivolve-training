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
5. **Kubernetes** environment to deploy Jenkins slave pods.

## Step-by-Step Setup

### 1. Set up Kubernetes namespaces
Create the necessary namespaces in your Kubernetes cluster for different environments (`dev`, `test`, `prod`):

```bash
kubectl create namespace dev
kubectl create namespace test
kubectl create namespace prod

## 2. Install ngrok
Install ngrok on the machine where Jenkins is running. To do this, run:

bash
Copy code
sudo apt install ngrok

## 3. Run ngrok
Start ngrok to create a public endpoint that will forward traffic to Jenkins (default port 8080):

bash
Copy code
ngrok http 8080
This will give you a public URL (e.g., http://random-id.ngrok.io). Copy this URL, as it will be used to configure the GitHub webhook.


## 4. Configure Webhook in GitHub
Go to your GitHub repository:

Navigate to Settings → Webhooks → Add webhook.
In the Payload URL, paste the ngrok URL followed by /github-webhook. For example:
bash
Copy code
http://random-id.ngrok.io/github-webhook
Set Content type to application/json.
Select Just the push event to trigger Jenkins builds on GitHub push events.

## 5. Set up Java 17 in Jenkins-slave
Ensure that Java 17 is installed and configured in Jenkins:

bash
Copy code
sudo apt install openjdk-17-jdk

## In Jenkins:

Go to Manage Jenkins → Global Tool Configuration.
Under JDK, add Java 17 either by selecting Install automatically or setting the path to your Java 17 installation.
6. Deploy Jenkins Slave in Different Namespace
In Kubernetes, you can deploy Jenkins slave pods in different namespaces to isolate the builds for each environment (e.g., dev, test, prod). Here’s how you can deploy Jenkins slaves in different namespaces:

Step 1: Deploy Jenkins Slave in Specific Namespace
To deploy a Jenkins slave in the dev, test, or prod namespace, use the Kubernetes interface to create a deployment for a Jenkins slave pod:

Ensure your Jenkins master is running and accessible from the Kubernetes cluster.
From Jenkins, configure a new Jenkins Agent that will connect to a Kubernetes pod (slave) running in the specific namespace.
Here are the general steps:

Create a Kubernetes Pod Template for Jenkins Slave:

In Jenkins, go to Manage Jenkins → Configure Clouds → Kubernetes.
Add a new Kubernetes cloud configuration (if not already configured).
Set the Kubernetes URL (Jenkins will automatically connect to the Kubernetes cluster if running in the same environment).
Configure the Slave Pod in Jenkins:

Add a pod template within the Kubernetes configuration in Jenkins.
Set the Namespace where you want the Jenkins slave to run (e.g., dev, test, or prod).
Configure the slave container to run the jenkins/inbound-agent image, ensuring it connects to the Jenkins master.
Define Resources for the Jenkins Slave:

You can specify the CPU and memory limits for the pod depending on the environment (e.g., different resources for prod vs dev).
Link the Slave to the Jenkins Job:

In the Jenkins job configuration, assign the job to run on the specific slave (e.g., jenkins-slave-dev for the dev namespace).
Step 2: Manually Assign Jenkins Jobs to the Specific Slave
Once your slave is running in the appropriate namespace, you can manually assign jobs to run on that slave. You can also configure Jenkins to automatically assign jobs based on labels or environments.

In the Build Executor section of the Jenkins job configuration, choose the appropriate slave node (e.g., jenkins-slave-dev for the dev namespace).
