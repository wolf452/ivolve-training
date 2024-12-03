#!/bin/bash

# Set threshold (10%)
THRESHOLD=10

# Email to send alerts
EMAIL="ahmed.software200@gmail.com"
SUBJECT="Disk Usage Warning: Root Filesystem"
MESSAGE="Warning: The disk usage for the root filesystem has exceeded $THRESHOLD%. Current usage is at $USAGE%."
# Get the current disk usage of the root file system
USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

# Check if usage exceeds the threshold
if [ "$USAGE" -gt "$THRESHOLD" ]; then

    echo -e "To: $EMAIL\nSubject: Disk Space Alert\n\nDisk usage alert: Root filesystem usage is ${USAGE}%, exceeding the threshold of ${THRESHOLD}%." \
    | msmtp --debug --from=default -t
fi
