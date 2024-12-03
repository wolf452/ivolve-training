
# Lab 1: User and Group Management

## Objective
Create a new group named `ivolve` and a new user assigned to this group with a secure password. Configure the user's permissions to allow installing Nginx with elevated privileges using the `sudo` tool (run `sudo` command for installing Nginx without a password).

---

## Steps

### 1. Configure User and Group

#### Create a New User
To create a user named `maher`, run the following command:
```bash
sudo useradd maher
```

#### Create a New Group
To create a group named `ivolve`, execute:
```bash
sudo groupadd ivolve
```

#### Add the User to the Group
To make the user `maher` a member of the `ivolve` group, use:
```bash
sudo usermod -aG ivolve maher
```

---

### 2. Modify Sudoers File
Edit the sudoers file to allow passwordless installation of Nginx:
```bash
sudo vim /etc/sudoers
```
Add the necessary configuration for the user.

---

### 3. Install Nginx
Run the following command to install Nginx:
```bash
sudo apt install nginx
```

---

### 4. Passwordless Installation for Other Packages
If required to install other packages without a password, ensure appropriate configurations in the sudoers file, then use:
```bash
sudo apt install <package-name>
```

Replace `<package-name>` with the desired package name.

---

## Notes
- Ensure all commands are executed with the necessary permissions.
- Verify the configurations in the `sudoers` file to avoid security risks

  
