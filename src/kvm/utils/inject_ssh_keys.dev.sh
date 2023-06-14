#!/bin/bash
exit
# For Executing using VSCode Selection
ssh deb2

# maybe copy this file to deb2


apt install sshpass expect -y

# Usecase
:`
1. create key / if exist
* add to ssh config
2. add key to guest (id_ed25519.pub)
`

# Test case
: multiple keys, like id_ed25519_1.pub, id_ed25519_2.pub
: two target1. then maybe try windows after

# Conclusion
* setup using sshpass is probably easier
* id_ed25519_2 isnt defaulted. must use ssh config or -i
* sftp cant use mkdir -p

# Setup


# add users host1 and target1
sudo adduser --gecos "" --disabled-password host1
echo "host1:asdf" | sudo chpasswd

sudo adduser --gecos "" --disabled-password target1
echo "target1:asdf" | sudo chpasswd

zsh <<< 2

# Connecting
su host1
su target1

# Reset
su host1 --command 'rm -rf ~/.ssh'
su target1 --command 'rm -rf ~/.ssh'
# Delete users / reset hard
sudo deluser --remove-home host1
sudo deluser --remove-home target1


# Implementation
# might need chmod

# create key in default location and make key if not exist
mkdir -p ~/.ssh;ssh-keygen -t ed25519 -C "host1@deb1" -f ~/.ssh/id_ed25519 -N "" <<< n

#make test keys
ssh-keygen -t ed25519 -C "host1@deb1 1" -f ~/.ssh/id_ed25519_1 -N "" <<< n
ssh-keygen -t ed25519 -C "host1@deb1 2" -f ~/.ssh/id_ed25519_2 -N "" <<< n

# copy only _2 to target. maybe good time to try sftp?
sshpass -p asdf ssh-copy-id -i ~/.ssh/id_ed25519_2.pub
# sftp host1@localhost:~/.ssh/id_ed25519 target1@localhost:~/.ssh/
# sftp ~/.ssh/id_ed25519_2.pub target1@localhost:~/.ssh/
echo 'put ~/.ssh/id_ed25519_2.pub' > sftp_commands.txt
# -o StrictHostKeyChecking=no

echo 'StrictHostKeyChecking No' > ~/.ssh/config
sshpass -p asdf sftp -b sftp_commands.txt target1@localhost:~/.ssh/
expect

# debug
tree ~/.ssh
rm -rf ~/.ssh
cat ~/.ssh/id_ed25519.pub

# Appendix
## doesnt work for ssh-keygen
set +e # reset
set -e # disable interactive mode


# ssh config tests like env
sshd -T | grep -i env
sshd -T | grep -i permitrootlogin


# redirect
command < input.txt
command <<EOF
input_line1
input_line2
EOF

# expect
# quite interesting....
expect script.expect

#!/usr/bin/expect -f
# no timeout
set timeout -1
set current_password "current_password"
set new_password "new_password"

# spawn is like exec. important for expect
spawn passwd
expect "password:"
# carriage return \r is important!
send "$current_password\r"
expect "password:"
send "$new_password\r"
expect "password:"
send "$new_password\r"
# on windows it might be '\r\n' instead of '\r'
expect eof

# ./script.expect hostname target1 password /path/to/local_key /path/to/remote_key
cat > inject-key.expect <<EOF
#!/usr/bin/expect -f

set timeout -1
set host [lindex $argv 0]
set username [lindex $argv 1]
set password [lindex $argv 2]
set local_key_path [lindex $argv 3]
set remote_key_path [lindex $argv 4]

spawn sftp $username@$host
expect "password:"
send "$password\r"
expect "sftp>"
send "put $local_key_path $remote_key_path\r"
expect "sftp>"
send "quit\r"
expect eof
EOF
chmod +x inject-key.expect
# ./inject-key.expect hostname username password /path/to/local_key /path/to/remote_key
# expect inject-key.expect hostname username password /path/to/local_key /path/to/remote_key
# i.e. target1@localhost
./inject-key.expect localhost target1 password ~/.ssh/id_ed25519_2 ~/.ssh
expect inject-key.expect localhost target1 password ~/.ssh/id_ed25519_2 ~/.ssh
ssh target1@localhost whoami
# so by default. the key needs to be specified
ssh -i ~/.ssh/id_ed25519_2 target1@localhost whoami

# manual step testing
sftp target1@localhost
sftp -i ~/.ssh/id_ed25519_2 target1@localhost
# expect 'target1@localhost's password:'
asdf
# expect 'Connected to localhost.'
# expect "sftp>"
put ~/.ssh/id_ed25519 .
put ~/.ssh/id_ed25519 ~/.ssh/id_ed25519

put .ssh/id_ed25519_2.pub .ssh/authorized_keys
# expect "sftp>"
"quit"

# also depends on the version... upgrading to 9+
# on 8 ~ didnt work
ls # remote
mkdir ~/ # doesnt work on 8.4
mkdir -p .ssh # doesnt work on 8.4
mkdir .ssh/blabla/bla/bla # doesnt work on 8.4

rmdir .ssh
mkdir .ssh

cd ~/ # # doesnt work on 8.4
lcd ~/ # works pwd
pwd # defaults to home...
lpwd
lls # local ls