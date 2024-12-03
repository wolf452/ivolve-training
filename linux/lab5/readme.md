
# Lab 5: Disk Management and Logical Volume Setup

## Objective
Attach a 15GB disk to your VM and partition it into sections of 5GB, 5GB, 3GB, and 2GB. The tasks include:
1. Using the first 5GB partition as a file system.
2. Configuring the 2GB partition as swap.
3. Initializing the second 5GB partition as a Volume Group (VG) with a Logical Volume (LV).
4. Extending the LV by adding the 3GB partition.

---

## Steps

### 1. Add Disk and Partition it (5GB, 5GB, 3GB, 2GB)
Use the `fdisk` utility:
```bash
sudo fdisk /dev/sdb
```
Follow the prompts to create partitions:
- 5GB `/dev/sdb1`
- 5GB `/dev/sdb2`
- 3GB `/dev/sdb3`
- 2GB `/dev/sdb4`

### 2. Format Partitions
#### Format the first partition (5GB) as a file system:
```bash
sudo mkfs.ext4 /dev/sdb1
```

#### Format the fourth partition (2GB) as swap:
```bash
sudo mkswap /dev/sdb4
sudo swapon /dev/sdb4
```

---

### 3. Configure Logical Volumes
#### Create a Physical Volume:
```bash
sudo pvcreate /dev/sdb2
```

#### Display Physical Volume details:
```bash
sudo pvdisplay
```

#### Create a Volume Group named `VG`:
```bash
sudo vgcreate VG /dev/sdb2
```

#### Create a Logical Volume named `lo` with 5GB:
```bash
sudo lvcreate -L +5G -n lo VG
```

---

### 4. Extend the Logical Volume
#### Convert the third partition (3GB) to a Physical Volume:
```bash
sudo pvcreate /dev/sdb3
```

#### Add the new Physical Volume to the Volume Group:
```bash
sudo vgextend VG /dev/sdb3
```

#### Extend the Logical Volume:
```bash
sudo lvextend -L +3G /dev/VG/lo
```


