
# Lab 2: Automate Disk Space Monitoring and Email Alerts

## Objective
Schedule a script to run daily at 5:00 PM to check disk space usage for the root filesystem and send an email alert if usage exceeds a 10% threshold.

---

## Steps

### 1. Script for Disk Space Monitoring
Create a script to automate checking disk space usage. For example:
```bash
#!/bin/bash

THRESHOLD=10
USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//')

if [ $USAGE -gt $THRESHOLD ]; then
    echo "Disk usage is above $THRESHOLD%. Current usage: $USAGE%" | mail -s "Disk Space Alert" user@example.com
fi
```

---

### 2. Install `msmtp`
Install `msmtp` to send emails using the SMTP protocol:
```bash
sudo apt install msmtp
```

---

### 3. Configure Email Sending
Create a configuration file `~/.msmtprc` with the following details:
```
account default
host smtp.gmail.com
port 587
auth on
user your-email@gmail.com
password your-app-password
tls on
tls_starttls on
```
> Replace `your-email@gmail.com` and `your-app-password` with your credentials.

---

### 4. Set Permissions
Secure the configuration file:
```bash
chmod 600 ~/.msmtprc
```

---

### 5. Schedule with Cron
Add a cron job to run the script daily at 5:00 PM:
```bash
crontab -e
```
Add the following line:
```bash
0 17 * * * /path/to/your/script.sh
```

---
