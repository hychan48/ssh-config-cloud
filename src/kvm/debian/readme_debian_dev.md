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
* https://wiki.archlinux.org/title/Dynamic_Kernel_Module_Support

# dump vbios with amdvbflash
* https://github.com/Zile995/PinnacleRidge-Polaris-GPU-Passthrough#configuration
* VIRSH_GPU_VIDEO 

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


* why did i upload open-ssh to github?
* should just link it with the release / mirror



## Systemmd timer
* trying on debian / ubuntu

* one second for 10 seconds
1. service
2. timer
```bash

# https://www.freedesktop.org/software/systemd/man/systemd.service.html

cat > /etc/systemd/system/helloworld.service <<EOF
[Unit]
Description=Hello World Service

[Service]
Type=oneshot
#ExecStart=/bin/bash -c "date '+%c' > /tmp/helloworld.txt"
ExecStart=/srv/helloworld.sh
RuntimeMaxSec=10s


[Install]
WantedBy=default.target
# WantedBy=helloworld.timer
EOF

# Timer file
# https://www.freedesktop.org/software/systemd/man/systemd.timer.html
# resolution is wrong
# Add the option AccuracySec=1us to the [Timer] section, to avoid the inaccuracy of the 1m default value of AccuracySec. Also see systemd.timer(5).
# i think RuntimeMaxSec is in service

cat > /etc/systemd/system/helloworld.timer <<EOF
[Unit]
Description=Hello World Timer

[Timer]
OnBootSec=1s
OnUnitActiveSec=1s
AccuracySec=1s
#apparently a problem here?
#RuntimeMaxSec=10s

[Install]
WantedBy=timers.target
EOF
## if changes were made post

sudo systemd-analyze verify /etc/systemd/system/helloworld.service
sudo systemd-analyze verify /etc/systemd/system/helloworld.timer

systemctl daemon-reload
systemctl daemon-reload --help
#   daemon-reexec                       Reexecute systemd manager?
systemctl restart helloworld
systemctl restart helloworld.timer
systemctl restart helloworld.service

# this is why i think i need a tool or a function for this
systemctl status helloworld
systemctl status helloworld | grep -C5 Active
systemctl status helloworld.timer | grep -C5 Active

systemctl status helloworld.timer
systemctl status helloworld.service


# verify
cat /etc/systemd/system/helloworld.service #
cat /etc/systemd/system/helloworld.timer #
cat /srv/helloworld.sh #

code -r /etc/systemd/system/helloworld.service #
code -r /etc/systemd/system/helloworld.timer #
code -r /srv/helloworld.sh #

cat /tmp/helloworld.txt # empty
tail -F /tmp/helloworld.txt # empty
# doesnt kill itself
# so declare in .service
# .timer is just for the timer.. which makes sense


# i think  it's defn relating to on timer
# test - then it started itself... lol
# i think i want transient
cat /tmp/helloworld.txt # empty
sudo systemctl start helloworld.timer
sudo systemctl status helloworld.timer | head
sudo systemctl start helloworld | head

sudo systemctl stop helloworld.timer # only one that works. with the way we linked them together
sudo systemctl stop helloworld.service
sudo systemctl stop helloworld

sudo systemctl restart helloworld.timer
sudo systemctl reload helloworld.timer

sudo systemctl is-enabled helloworld.timer #
sudo systemctl is-enabled helloworld #
sudo systemctl start helloworld # i think it's this # or not.. this only runs it once
sudo systemctl status helloworld # i think it's this # or not.. this only runs it once



# this doesnt need to be on? intersting but not timing out...
sudo systemctl status helloworld | head
sudo systemctl start helloworld
sudo systemctl stop helloworld
sudo systemctl restart helloworld


# need to erstart the service too? or what

sudo systemctl reload helloworld.timer
sudo systemctl restart helloworld.timer
sudo systemctl stop helloworld.timer
sudo systemctl enable helloworld.timer
sudo systemctl disable helloworld.timer

# debug
tree /etc/systemd/system/ # so usually not in the root folder
ll /etc/systemd/system/ # directory is called wants?
systemctl list-timers
systemctl list-timers --all

# generator lol
# https://systemd-timer.havrlent.com/

systemd-analyze calendar "Mon,Tue *-*-01..04 12:00:00"

# after 30 seconds touch /tmp/foo
systemd-run --on-active=30 /bin/touch /tmp/foo
# also --user # only if user is logged in already
# should maybe go find the run-r09*.timer and run-r09*.service


# transient timers - i think using node is still easier / or just crontab
#https://wiki.archlinux.org/title/systemd/Timers
# systemd-run --on-active=30 /bin/touch /tmp/foo
# apparently no mailto. unlike crontab

# oh shit faketime? for testing?
# ohh.. maybe just use timeout or something instead
```

* transient timers exit
* need to look at file watchers / ntfs / inotify etc.


