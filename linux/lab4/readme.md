
# Lab 4: DNS and Network Configuration with Hosts File and BIND9

## Objective
This lab demonstrates the differences between using the `hosts` file and DNS for URL resolution. The tasks include:
1. Modifying the `hosts` file to resolve a URL to a specific IP address.
2. Configuring BIND9 as a DNS solution to resolve wildcard subdomains.
3. Verifying the configuration using `dig` or `nslookup`.

---

## Steps

### 1. Update `/etc/hosts`
Add the following record to resolve a URL to a specific IP address:
```
192.168.1.10 ahmed-ivolve.com
```

---

### 2. Install and Configure BIND9
Install BIND9:
```bash
sudo apt install bind9
```

#### Configuration Steps
1. **Create a Configuration File:**
   Create a new file named `Domain` and include the following:
   ```
   domain: ahmed-ivolve.com
   ip: 192.168.1.10
   ```

2. **Wildcard Subdomains:**
   Use `*` to represent all subdomains for a domain. For example:
   - Any subdomain under `ahmed-ivolve.com` will resolve to the same IP without needing individual definitions.

3. **Define the Zone:**
   Open the file `named.conf.local` and define a new zone for `ahmed-ivolve.com`:
   - Specify the domain and the settings path.

---

### 3. Verify Configuration
Run the following command to test DNS resolution:
```bash
dig @127.0.0.1 a.ahmed-ivolve.com
```

---

### 4. Configure `/etc/resolv.conf`
On the client/server using the BIND9 DNS, update the `resolv.conf` file:
```
nameserver <BIND9_Server_IP>
```

---

## Testing
Verify that DNS queries for the domain and its subdomains are resolved correctly using tools like `dig` or `nslookup`.

---
