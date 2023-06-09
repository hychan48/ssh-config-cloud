#!/bin/bash
cat <<EOF
ssh deb2
ssh localhost



EOF

# autogenerates the folder as well...
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ''
mkdir -p ~/.ssh/authorized_keys.d
cat ~/.ssh/id_ed25519.pub > ~/.ssh/authorized_keys.d/deb2

cat > ~/.ssh/config <<EOF
Host localhost
   Hostname 127.0.0.1
   User root
   IdentityFile ~/.ssh/id_ed25519
   StrictHostKeyChecking no

EOF

cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys

# authorized_keys.d doesnt work
* just look into readme_ssh.md for the script
* need to clean the repo up

