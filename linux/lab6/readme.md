
# SSH Configuration Guide

This guide provides instructions to generate SSH keys, configure your SSH connection, and enable seamless access to a remote machine.

## Objective

Enable SSH from your machine to another virtual machine (VM) using public and private keys, and configure SSH to allow running the command `ssh ivolve` without specifying the username, IP address, or key.

---

## Steps

### 1. Install the SSH Service
To begin, ensure the SSH service is installed and running on your machine:

```bash
sudo apt install sshd
sudo systemctl enable --now ssh
```

---

### 2. Generate Public and Private Keys
Run the following command to generate a new SSH key pair:

```bash
ssh-keygen -t rsa -b 4096 -C "ivolvekey"
```

---

### 3. Copy the Public Key to the Remote Machine
Use the following command to copy the public key to the remote machine:

```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub ahmed@192.168.216.136
```

Replace `ahmed@192.168.216.136` with your username and IP address if they differ.

---

### 4. Configure SSH for Seamless Access
Edit your SSH configuration file to enable quick access:

1. Open the SSH config file:
    ```bash
    nano ~/.ssh/config
    ```

2. Add the following configuration:
    ```
    Host ivolve
        HostName 192.168.216.136
        User ahmed
        IdentityFile ~/.ssh/id_rsa
    ```

Save and exit the editor.

---

### 5. Test the Configuration
Now, you can connect to the remote machine by simply running:

```bash
ssh ivolve
```

---


