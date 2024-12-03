
# Ansible Setup and Usage Guide

This repository contains instructions for setting up and using Ansible for managing servers.

## Prerequisites

- **Operating System**: Linux-based (tested on Ubuntu)
- **Tools Required**:
  - `ansible`

## Installation

### Step 1: Install Ansible
To install Ansible, use the following command:
```bash
sudo apt install ansible
```

### Step 2: Generate and Copy SSH Keys
Ensure you have an SSH key pair to connect to your servers securely. Run the following commands:

1. Generate the SSH key pair:
   ```bash
   ssh-keygen -t rsa -b 4096
   ```

2. Copy the public key to the target server:
   ```bash
   ssh-copy-id -i ~/.ssh/id_rsa.pub ahmed@192.168.216.137
   ```

## Setting Up Inventory

Create an **Inventory** file that contains the IPs of the servers you want to manage using Ansible. Additionally, define the private key path for authentication.

### Example Inventory File
```ini
[servers]
192.168.216.137 ansible_ssh_private_key_file=~/.ssh/id_rsa
```

## Running Ansible Commands

### Ad-Hoc Command
Use the following format to execute ad-hoc commands with Ansible:
```bash
ansible -i inventory servername -a "df -h"
```

### Purpose
This command checks the storage and mounted partitions of the server.

