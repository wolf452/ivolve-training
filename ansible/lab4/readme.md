
# My Ansible Project

## Overview
This project automates the deployment of:
- Jenkins
- Docker
- OpenShift CLI (oc)

The project is organized using **Ansible Roles** for better modularity and maintainability.

---

## Project Structure
```
my_ansible_project/
├── ansible.cfg                 # Ansible configuration file
├── inventory                   # Inventory file with target hosts
├── playbook.yml                # Main playbook to execute roles
├── roles/                      # Folder containing Ansible roles
│   ├── jenkins/                # Role for installing Jenkins
│   ├── docker/                 # Role for installing Docker
│   ├── openshift/              # Role for installing OpenShift CLI
```

---

## Prerequisites
1. **Ansible** installed on your local machine:
   ```bash
   sudo apt update && sudo apt install ansible -y
   ```

2. **Target host** (e.g., an EC2 instance) with:
   - SSH access configured.
   - A user with `sudo` privileges.

3. Update the **inventory** file with your target host details:
   ```ini
   [all]
   ec2-54-91-123-1.compute-1.amazonaws.com ansible_user=ubuntu ansible_ssh_private_key_file=/path/to/private-key.pem
   ```

---

## How to Use
1. Clone the repository or copy the project files to your machine.
2. Navigate to the project directory.
3. Run the playbook:
   ```bash
   ansible-playbook -i inventory playbook.yml
   ```

---

## Roles Description

### **Jenkins**
- Installs Jenkins and starts the service.
- Adds the official Jenkins repository.

### **Docker**
- Installs Docker CE.
- Configures Docker to start automatically on system boot.

### **OpenShift CLI**
- Downloads and installs the OpenShift CLI (oc).
- Cleans up temporary installation files.

Each role is modular and can be used independently.

---

## Customization
### OpenShift CLI Version
You can update the OpenShift CLI version by editing the `openshift_version` variable in:
```yaml
roles/openshift/defaults/main.yml
```

---

## Troubleshooting
- Ensure the target machine has internet access.
- Check Ansible logs for detailed error messages.
- Verify your SSH key and inventory file configuration.

---


