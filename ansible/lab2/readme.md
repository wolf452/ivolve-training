
# Ansible Project: Automating NGINX Deployment

This repository demonstrates using Ansible to automate tasks such as installing NGINX, managing its service, and deploying an HTML file.

## Prerequisites

- **Tools Required**:
  - Ansible installed on the control node.
- **Resources**:
  - Access to the target servers with proper SSH keys.

---

## Configuration Steps

### 1. Define Inventory
Use the `vim` editor to create or edit the inventory file:
```bash
vim inventory
```

### 2. Configure `ansible.cfg`
Set the inventory path and privilege escalation options in the Ansible configuration file:
```bash
vim ansible.cfg
```
Specify:
- Path to the inventory file.
- User that Ansible will use for managing the target system.

---

## Creating the Playbook

### Define the Playbook
Write the playbook in `playbook.yml`:
```bash
vim playbook.yml
```
This playbook will:
1. Install NGINX.
2. Manage its service (start/stop/restart).
3. Deploy an `index.html` file.

---

## Running the Playbook

### Execute with Ansible
To run the playbook, use the following command:
```bash
ansible-playbook -i inventory playbook.yml --private-key=./ahmed.pem -u ec2-user
```

- **Options Explained**:
  - `-i inventory`: Specifies the inventory file.
  - `--private-key=./ahmed.pem`: Uses the private key for authentication.
  - `-u ec2-user`: Specifies the username for the remote server.

---

## Output
After running the playbook, you should see:
1. NGINX installed on the target servers.
2. The service properly managed.
3. An HTML file deployed to the web server.


