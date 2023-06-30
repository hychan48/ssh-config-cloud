# OpenSSH

## Dump
```bash
ssh-keygen -q -t ed25519 -f ~/.ssh/id_ed25519 -N ""
ssh-keygen -t ed25519
sshd -T # gets loaded options

```


## Dev user Creation
<<< @../../../src/kvm/utils/create-demo-users.dev.sh

## Inject SSH Keys
:::details
<<< @../../../src/kvm/utils/inject_ssh_keys.sh {bash} [inject_ssh_keys.sh]

[//]: # (<<< @/snippets/snippet-with-region.js#snippet{1,2 ts:line-numbers} [snippet with region])

:::

## Control Test
```bash
# 200ms
* target and control are same user
/usr/bin/time ssh target1 'echo hi' 2>&1|grep elapsed

# 0 second time
/usr/bin/time ssh control1 'echo hi' 2>&1|grep elapsed

# 
mkdir -p ~/.ssh/sockets
ssh -O check control1
ssh -O exit control1
#
ls /root/.ssh/sockets/target1@localhost-22
ls /root/.ssh/sockets/
tree /root/.ssh/sockets/
```
```ssh-config
StrictHostKeyChecking no
Host control1
  hostname localhost
  user target1 
  ControlMaster auto
  ControlPath ~/.ssh/sockets/%r@%h-%p
  ControlPersist 600
Host target1
  hostname localhost
  user target1
  StrictHostKeyChecking no
  ControlMaster no
```

## port forward
```bash
#!/bin/bash

# SSH port forwarding
ssh -f -N -L 59001:localhost:5900 user@hostname
# -f -N options. -f runs SSH in the background, and -N prevents executing a remote command.
# -L means local port forwarding
# Launch VNC Viewer
tvnviewer -p 2022 localhost
```
