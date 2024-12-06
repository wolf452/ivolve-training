
# AWS S3 CLI and SDK Interactions

This document provides detailed instructions for creating and managing an S3 bucket using AWS CLI. The operations include creating a bucket, configuring permissions, enabling versioning and logging, and uploading/downloading files.

---

## 1. Create an S3 Bucket
To create the bucket `my-s3-bucket-ivolve`, run:
```bash
aws s3api create-bucket --bucket my-s3-bucket-ivolve --region us-east-1
```

---

## 2. Attach Bucket Policy
Save the following policy into a file named `policy.json`:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::160337832336:user/ahmed"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::my-s3-bucket-ivolve/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::160337832336:user/ahmed"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-s3-bucket-ivolve/*"
    }
  ]
}
```

To attach this policy to the bucket, use:
```bash
aws s3api put-bucket-policy --bucket my-s3-bucket-ivolve --policy file://policy.json
```

---

## 3. Enable Versioning
To enable versioning for the bucket:
```bash
aws s3api put-bucket-versioning --bucket my-s3-bucket-ivolve --versioning-configuration Status=Enabled
```

---

## 4. Enable Logging
### Step 1: Update the Bucket Policy for Logging
Add the following statement to the `policy.json`:
```json
{
  "Effect": "Allow",
  "Principal": {
    "Service": "logging.s3.amazonaws.com"
  },
  "Action": "s3:PutObject",
  "Resource": "arn:aws:s3:::my-s3-bucket-ivolve/logs/*"
}
```
Reapply the updated policy:
```bash
aws s3api put-bucket-policy --bucket my-s3-bucket-ivolve --policy file://policy.json
```

### Step 2: Configure Logging
Run this command to enable logging for the bucket:
```bash
aws s3api put-bucket-logging --bucket my-s3-bucket-ivolve --bucket-logging-status '{
  "LoggingEnabled": {
    "TargetBucket": "my-s3-bucket-ivolve",
    "TargetPrefix": "logs/"
  }
}'
```

---

## 5. Upload Files to the Bucket
To upload a file (e.g., `policy.json`) to the bucket:
```bash
aws s3 cp policy.json s3://my-s3-bucket-ivolve/
```

---

## 6. Download Files from the Bucket
To download the file `policy.json` from the bucket to your local system:
```bash
aws s3 cp s3://my-s3-bucket-ivolve/policy.json ./policy.json
```

---

## 7. Verify Configuration
### Check Bucket Versioning:
```bash
aws s3api get-bucket-versioning --bucket my-s3-bucket-ivolve
```

### Check Bucket Logging:
```bash
aws s3api get-bucket-logging --bucket my-s3-bucket-ivolve
```

### List Bucket Contents:
```bash
aws s3 ls s3
