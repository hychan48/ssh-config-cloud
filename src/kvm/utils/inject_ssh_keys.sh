#!/bin/bash
# on host / local machine
# it defautls to ~/.ssh/id_ed25519...
# set batch mode
# set +e
set -e

# generate id_25519 to default location if not exist
mkdir -p ~/.ssh;ssh-keygen -t ed25519 -C "host1@deb1" -f ~/.ssh/id_ed25519 -N "" <<< n
# check if sshpass is installed
if ! command -v sshpass &> /dev/null
then
    echo "sshpass could not be found"
    echo "installing sshpass"
    sudo apt install sshpass -y 
    # wont work if no sudo access obviously
fi

# setup ssh config
# :`
# rm -f ~/.ssh/config
# tree -a ~/.ssh
# `

# create ssh config if not exist
test -f ~/.ssh/config || touch ~/.ssh/config

# or your own ssh config... we dont replace here
if ! grep -q "Host target1" ~/.ssh/config
then
    # IdentityFile C:\Users\Jason\.ssh\id_ed25519
    # ProxyJump vdid-jump
    # UserKnownHostsFile /dev/null
    cat >> ~/.ssh/config <<EOF
Host target1
  hostname localhost
  user target1
  StrictHostKeyChecking no
EOF

fi

# sshpass -p asdf ssh -i ~/.ssh/id_ed25519.pub target1@localhost whoami
# sshpass -p asdf ssh -i ~/.ssh/id_ed25519.pub target1@localhost "whoami"
# PUB_KEY=$(cat ~/.ssh/id_ed25519.pub);sshpass -p asdf ssh target1@localhost "mkdir -p ~/.ssh;echo $PUB_KEY >> ~/.ssh/authorized_keys"
sshpass -p asdf ssh target1@localhost 'rm -rf ~/.ssh'
# create if not exist
PUB_KEY=$(cat ~/.ssh/id_ed25519.pub);sshpass -p asdf ssh target1@localhost "mkdir -p ~/.ssh;grep -q \"$PUB_KEY\" ~/.ssh/authorized_keys || (echo \"$PUB_KEY\" >> ~/.ssh/authorized_keys)"

# For testing
# sshpass -p asdf ssh target1@localhost
ssh target1@localhost "tree -a ~/.ssh"
ssh target1@localhost "cat ~/.ssh/authorized_keys"
sshpass -p asdf ssh target1@localhost "cat ~/.ssh/authorized_keys"

# isnt usin curl like easier? curl is infact installed