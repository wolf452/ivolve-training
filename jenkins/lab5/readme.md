# Lab 26: MultiBranch Pipeline Project

This repository demonstrates how to set up a **Jenkins CI/CD Pipeline** integrated with **GitHub Webhook**, **ngrok** for external access, and **Java 17** to manage the deployment in Kubernetes namespaces.

## Project Objectives
1. **Create 3 namespaces in Kubernetes**: `dev`, `test`, and `prod`.
2. **Create a Multi-Branch Pipeline** to automate deployment in these namespaces based on the GitHub branch (`main`, `second`, `third`).
3. **Set up a Jenkins slave** to run the pipeline.
4. **Integrate GitHub Webhook with ngrok** to trigger Jenkins builds on GitHub events.

## Prerequisites
Before starting the setup, ensure you have the following:
1. **Jenkins** instance running locally or on a server.
2. **GitHub** repository to integrate with Jenkins.
3. **ngrok** installed to generate a public URL for Jenkins to receive webhooks from GitHub.
4. **Java 17** installed on Jenkins for running builds.

## Step-by-Step Setup

### 1. Set up Kubernetes namespaces
Create the necessary namespaces in your Kubernetes cluster for different environments (dev, test, prod):

```bash
kubectl create namespace dev
kubectl create namespace test
kubectl create namespace prod
2. Install ngrok
Install ngrok on the machine where Jenkins is running. To do this, run:

bash
Copy code
sudo apt install ngrok
### 3. Run ngrok
Start ngrok to create a public endpoint that will forward traffic to Jenkins (default port 8080):

bash
Copy code
ngrok http 8080
This will give you a public URL (e.g., http://random-id.ngrok.io). Copy this URL, as it will be used to configure the GitHub webhook.
![install package](https://github.com/user-attachments/assets/36b8e38b-ed69-43d1-9e71-f27aef5113cf)
![config ng](https://github.com/user-attachments/assets/6e7d21d5-ffb2-4a83-968d-9f506600a71e)


4. Configure Webhook in GitHub
Go to your GitHub repository:

Navigate to Settings → Webhooks → Add webhook.
In the Payload URL, paste the ngrok URL followed by /github-webhook. For example:
bash
Copy code
http://random-id.ngrok.io/github-webhook
Set Content type to application/json.
Select Just the push event to trigger Jenkins builds on GitHub push events.
![edit webhook](https://github.com/user-attachments/assets/b9c30f93-1686-4278-8762-397e4d970238)

5. Set up Java 17 in Jenkins
Ensure that Java 17 is installed and configured in Jenkins:

bash
Copy code
sudo apt install openjdk-17-jdk
![slave](https://github.com/user-attachments/assets/fae54afd-38f2-4ad7-a912-9606da3be022)

In Jenkins:

Go to Manage Jenkins → Global Tool Configuration.
Under JDK, add Java 17 either by selecting Install automatically or setting the path to your Java 17 installation.
6. Test the Webhook
![finish webhook](https://github.com/user-attachments/assets/713e6a16-d280-40bc-8daa-649f6bb9e175)

To verify the webhook configuration:

Push changes to your GitHub repository.
Jenkins should receive the webhook and trigger a build.
7. Set Up Multi-Branch Pipeline (main, second, third)
Step 1: Install the Multibranch Pipeline Plugin
In Jenkins:

Go to Manage Jenkins → Manage Plugins.
Install the "Multibranch Pipeline" plugin (if it’s not already installed).
Step 2: Create the Multi-Branch Pipeline Job
From the Jenkins UI:

Click New Item.
Enter the name of the pipeline (e.g., multi-branch-pipeline), and select Multibranch Pipeline.
Click OK.
Step 3: Set Up GitHub Repository for Jenkins
In the Branch Sources section:

Click Add Source → GitHub.
Provide GitHub credentials (you may need to generate a personal access token in GitHub to authenticate Jenkins with GitHub).
Enter the GitHub repository URL (e.g., https://github.com/your-repo).
