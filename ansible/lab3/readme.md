
# Ansible MySQL Setup with Vault

## Description

This project provides an Ansible playbook to automate the installation of MySQL, creation of a database (`ivolve`), and setting up a user with full privileges on the database. Sensitive information, such as database credentials, is securely managed using Ansible Vault.

## Features

- Install MySQL server.
- Create a database named `ivolve`.
- Create a database user with full privileges.
- Encrypt sensitive data using Ansible Vault.

## Requirements

- **Ansible** (version >= 2.9)
- A target machine with:
  - SSH access
  - Sudo privileges for the user running the playbook
- MySQL server compatibility.

## Setup

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. **Create an Ansible Vault file**:
   Use the following command to create a Vault file to store sensitive variables (e.g., database username and password):
   ```bash
   ansible-vault create vars/vault.yml
   ```
   Add the following content:
   ```yaml
   db_username: <your_username>
   db_password: <your_password>
   ```

3. **Configure the inventory**:
   Update the `inventory` file with the target machine details.

4. **Edit `ansible.cfg`**:
   Configure `ansible.cfg` for optimal management of Ansible behavior (e.g., inventory paths).

5. **Write your playbook**:
   Tasks are defined in `playbook.yml` to:
   - Install MySQL
   - Create the database `ivolve`
   - Create the user with privileges

## Running the Playbook

To run the playbook, use the following command:
```bash
ansible-playbook playbook.yml --ask-vault-pass
```


