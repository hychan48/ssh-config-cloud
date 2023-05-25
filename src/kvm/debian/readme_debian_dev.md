# Readme Debian Tasks Dev
**Task 1: Pick a Git Repo Name**

Coming up with a suitable Git repository name is important as it's an identifier for your project. As per your description, your repo will be used for consolidating scripts with a focus on SSH authorized_keys setup and End-to-end testing (specifically on Debian). Considering these factors, here are a few suggestions for a git repository name:

1. `ssh-debian-setup`
2. `debian-net-tester`
3. `ssh-auth-key-manager`
4. `debian-e2e-scripts`

Choose the one that best fits your needs, or use them as inspiration to come up with your own.

**Task 2: Combine Code for Setting Up SSH Authorized_Keys**

Here is a simple script to add an SSH key to the authorized keys file. This script takes the username and the public SSH key as input and adds it to the `authorized_keys` file of that user.

```bash
#!/bin/bash

# Define variables
USERNAME="$1"
PUB_KEY="$2"

# Path to the user's home directory
HOME_DIR=$(eval echo "~${USERNAME}")

# Check if .ssh directory exists
if [ ! -d "${HOME_DIR}/.ssh" ]; then
    mkdir "${HOME_DIR}/.ssh"
    chmod 700 "${HOME_DIR}/.ssh"
fi

# Add the public key to authorized_keys
echo "${PUB_KEY}" >> "${HOME_DIR}/.ssh/authorized_keys"
chmod 600 "${HOME_DIR}/.ssh/authorized_keys"
```

Usage: `./add_key.sh username "ssh-rsa AAAA..."`

**Task 3: E2E Testing (Debian with internet)**

Let's break this into sub-tasks:

*Verify or install sshd is running:*

```bash
#!/bin/bash

# Check if sshd is running
if service ssh status; then
    echo "sshd is running"
else
    echo "sshd is not running, starting now"
    service ssh start
fi
```

*Verify DNS / Network:*

```bash
#!/bin/bash

# Check internet connection by pinging Google DNS
if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
    echo "IPv4 is up"
else
    echo "IPv4 is down"
fi
```
