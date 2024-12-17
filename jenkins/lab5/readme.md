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
-
### 3. mdfkdmfkd
