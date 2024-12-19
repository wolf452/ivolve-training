# Jenkins Installation Guide

This document provides steps for installing Jenkins either as a service or inside a container.

## Table of Contents
1. [Install Jenkins as a Service](#install-jenkins-as-a-service)
2. [Install Jenkins as a Container](#install-jenkins-as-a-container)

---

## Install Jenkins as a Service

Follow the steps below to install Jenkins as a service on a Linux machine.

### Step 1: Update System Packages
Make sure your system is up-to-date:
```bash
sudo apt update
sudo apt upgrade -y
```
### Step 2: Install Java
Jenkins requires Java to run. Install OpenJDK 11:

```bash
sudo apt install openjdk-11-jdk -y
```
Verify the installation:

bash
```
java -version
```
### Step 3: Add Jenkins Repository
Add Jenkins repository and import the GPG key:

```bash

wget -q -O - https://pkg.jenkins.io/jenkins.io.key | sudo tee /etc/apt/trusted.gpg.d/jenkins.asc
```
Add the Jenkins repository:

```bash
sudo sh -c 'echo deb http://pkg.jenkins.io/debian/ stable main > /etc/apt/sources.list.d/jenkins.list'
```
### Step 4: Install Jenkins
Update package lists and install Jenkins:

```bash

sudo apt update
sudo apt install jenkins -y
```
### Step 5: Start Jenkins Service
Start the Jenkins service and enable it to start on boot:

```bash

sudo systemctl start jenkins
sudo systemctl enable jenkins
```
### Step 6: Access Jenkins
Open a browser and go to http://localhost:8080 to access the Jenkins UI.

### Step 7: Unlock Jenkins
Retrieve the Jenkins unlock key:

```bash

sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
Paste the unlock key into the web interface.

### Step 8: Complete Setup
Follow the on-screen prompts to install the necessary plugins and create an admin user.

# Install Jenkins as a Container
If you prefer to run Jenkins inside a container, follow these steps.

### Step 1: Install Docker
Install Docker if not already installed:

```bash
sudo apt update
sudo apt install docker.io -y
```
Start and enable Docker service:

```bash

sudo systemctl start docker
sudo systemctl enable docker
```
### Step 2: Pull Jenkins Docker Image
Pull the latest Jenkins LTS Docker image:

```bash
docker pull jenkins/jenkins:lts
```
### Step 3: Run Jenkins Container
Run Jenkins in a Docker container:

```bash

docker run -d -p 8080:8080 -p 50000:50000 --name jenkins -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts
```
This will:
Run Jenkins in detached mode.
Expose ports 8080 and 50000.
Persist Jenkins data using the jenkins_home volume.
### Step 4: Access Jenkins
Access Jenkins at http://localhost:8080.

### Step 5: Unlock Jenkins
To unlock Jenkins, use the following command:

```bash

docker exec -it jenkins  bash 
cat /var/jenkins_home/secrets/initialAdminPassword

```
Use the unlock key to access the web interface.

### Step 6: Complete Setup
Follow the setup instructions as mentioned in Install Jenkins as a Service.

Cleanup (Optional)
To remove the Jenkins container, run:

bash
```
docker stop jenkins
docker rm jenkins
```
