# DHCP Hostname for KVM

# Best way to test xml DNS
* libvirt dns only no dnsmasq or bind
```bash
# destroy / start
systemctl restart systemd-resolved
# * dhcp-cleanup.sh

dig +short myhost @192.168.122.1
```


* default kvm

## test
1. remove only json for virbr0.macs
  * just use python... it's already installed
2. Try adding localhostname for nat only

```bash
rm /var/lib/libvirt/dnsmasq/virbr0*
virsh net-destroy default

# stop

virsh net-start default

```




# Test Scripts
```bash
#!/bin/bash
# zsh arrays are different...
VMS=("ubh1-1" "ubh1-2")
VMS=("win2k19-1" "win2k19-2")

VMS=("ubh1-1" "ubh1-2" "win2k19-1" "win2k19-2")

for VM in "${VMS[@]}"
do
  # loop
   echo on vm $VM
  #  virsh destroy $VM --graceful
  #  virsh shutdown $VM
  #  virsh start $VM
  # ping -c 1 localhost
  # ping -c 1 localhost
  # dig +short @192.168.122.1 $VM
  virsh domifaddr ub5
  virsh domifaddr ub5 --source agent
  (virsh domifaddr "$VM" | awk '/ipv4/ {print $4}' | awk -F'/' '{print $1}')
  ping -c 1 $(virsh domifaddr "$VM" | awk '/ipv4/ {print $4}' | awk -F'/' '{print $1}')
   
done

```
# qemu-guest-agent
```bash
virsh shutdown ub5 --mode=agent
virsh domtime ub5 --mode=agent
virsh domifaddr --source agent ub5

virsh qemu-agent-command --domain ub5 '{"execute":"guest-ping"}' --pretty
virsh qemu-agent-command --domain ub5 '{"execute":"guest-info"}' --pretty
```
## executing commands directly with qemu-agent

* https://technekey.com/simplifying-vm-management-executing-commands-in-guest-vms-using-virsh/
* python script for parsing they have

```bash
# execute
virsh -c qemu:///system qemu-agent-command test-vm '{"execute": "guest-exec", "arguments": { "path": "apt", "arg": [ "install","cowsay","-y" ], "capture-output": true }}'  --pretty

# verify
virsh -c qemu:///system qemu-agent-command test-vm   '{"execute": "guest-exec-status", "arguments": { "pid": 1993 }}' --pretty
:
'{
  "return": {
    "pid": 1993
  }

  {
  "return": {
    "exitcode": 0,
    "err-data": "CldBUk5JTkc6IGFwdCBkb2VzIG5vdCBoYXZlIGEgc3RhYmxlIENMSSBpbnRlcmZhY2UuIFVzZSB3aXRoIGNhdXRpb24gaW4gc2NyaXB0cy4KCg==",
    "out-data": "UmVhZGluZyBwYWNrYWdlIGxpc3RzLi4uCkJ1aWxkaW5nIGRlcGVuZGVuY3kgdHJlZS4uLgpSZWFkaW5nIHN0YXRlIGluZm9ybWF0aW9uLi4uCmNvd3NheSBpcyBhbHJlYWR5IHRoZSBuZXdlc3QgdmVyc2lvbiAoMy4wMytkZnNnMi04KS4KMCB1cGdyYWRlZCwgMCBuZXdseSBpbnN0YWxsZWQsIDAgdG8gcmVtb3ZlIGFuZCA0IG5vdCB1cGdyYWRlZC4K",
    "exited": true
  }
}
}'
```



# 
virsh net-dhcp-leases default
# * literally just a filter
virsh net-dhcp-leases default --mac 52:54:00:3b:77:a6 # win
virsh net-dhcp-leases default --mac 52:54:00:4f:94:bf # ub

virsh dumpxml ubh1-2 |grep uuid
virsh dumpxml ubh1-2 | grep "01:52:54" # bnnot found..
virsh dumpxml ubh1-2 | grep net # bnnot found..
virsh dumpxml ubh1-2 | bgrep net # bnnot found..
virsh domiflist --domain "win2k19-1"
virsh domiflist --inactive --domain "win2k19-2"
virsh domiflist --domain "ubh1-2"
virsh domiflist --inactive --domain "ubh1-2"
# 3rd row 5th column (counting from 1)
virsh domiflist --domain "ubh1-2" | awk 'NR==3 {print $5}' # mac of vm name

alias bgrep='grep --color=auto -A 2 -B 2'
```


# Dnsmasq
```bash
sudo systemctl restart dnsmasq
sudo systemctl status dnsmasq

# dns masq not running by default...
# might need to kill virbr0.macs and virbr0.status
ip neigh # ip neighbor to get a list of macs

vmn="ubh1-1";(virsh domifaddr "$vmn" | awk '/ipv4/ {print $4}' | awk -F'/' '{print $1}')
```

# Appendix
## virsh net-edit default
* og
```xml
<!-- <network connections='4'> -->
<network>
  <name>default</name>
  <uuid>b23fa676-61df-412d-b621-75e60472bfa3</uuid>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:e3:06:b6'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
```
```bash

```
```xml
<!-- Only adding domain witout dns . works! dns -->
<!-- https://liquidat.wordpress.com/2017/03/03/howto-automated-dns-resolution-for-kvmlibvirt-guests-with-a-local-domain/ -->
<!-- https://libvirt.org/formatnetwork.html#id10 -->
<network>
  <name>default</name>
  <uuid>b23fa676-61df-412d-b621-75e60472bfa3</uuid>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:e3:06:b6'/>
  <domain name="hpe1.localdomain"/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
```
```xml
<network>
  <name>default</name>
  <uuid>b23fa676-61df-412d-b621-75e60472bfa3</uuid>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:e3:06:b6'/>
  <domain name="hpe1.localdomain"/>
  <dns>
  <!-- defn works... might be better just to do it inside of the dhcp ?
  has to be ? might need to add enabled no to dns
  -->
    <host ip='192.168.122.1'>
      <hostname>myhost</hostname>
      <hostname>myhostalias</hostname>
      <hostname>kvmhost</hostname>
      <hostname>kvm.hpe1.localdomain</hostname>
      <hostname>hpe-01.amd.com</hostname>
    </host>
  </dns>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
```
```xml
<!-- https://libvirt.org/formatnetwork.html -->
<!-- localPtr in ip might be useful as well -->
<domain name="example.com"/>
<dns>
  <txt name="example" value="example value"/>
  <forwarder addr="8.8.8.8"/>
  <forwarder domain='example.com' addr="8.8.4.4"/>
  <forwarder domain='www.example.com'/>
  <srv service='name' protocol='tcp' domain='test-domain-name' target='.'
    port='1024' priority='10' weight='10'/>
  <host ip='192.168.122.2'>
    <hostname>myhost</hostname>
    <hostname>myhostalias</hostname>
  </host>
</dns>
<ip address="192.168.122.1" netmask="255.255.255.0" localPtr="yes">
</ip>
```


## Macs
* `cat /var/lib/libvirt/dnsmasq/virbr0.macs`
 # comes back on vm start
* check if virsh net-destroy clears these
```jsonc
[
  {
    "domain": "win2k19-2",
    "macs": [
      "52:54:00:3b:77:a6" 
    ]
  },
  {
    "domain": "ubh1-1",   
    "macs": [
      "52:54:00:4f:94:bf" 
    ]
  },
  {
    "domain": "ubh1-2",   
    "macs": [
      "52:54:00:9d:cb:a8"
    ]
  },
  {
    "domain": "win2k19-1",
    "macs": [
      "52:54:00:8e:27:43"
    ]
  }
]
```

# Status - dhcp
* `cat /var/lib/libvirt/dnsmasq/virbr0.status`
  * updates when net-start
* check if virsh net-destroy clears these
* same as `virsh net-dhcp-leases default` i believe
```jsonc
[
  {
    "ip-address": "192.168.122.26",
    "mac-address": "52:54:00:09:a8:a7",
    "hostname": "ubh1-1",
    "client-id": "01:52:54:00:09:a8:a7",
    "expiry-time": 1687899580
  },
  {
    "ip-address": "192.168.122.102",
    "mac-address": "52:54:00:4f:94:bf",
    "hostname": "ubh1-1",
    "client-id": "01:52:54:00:4f:94:bf",
    "expiry-time": 1687902542
  },
  {
    "ip-address": "192.168.122.105",
    "mac-address": "52:54:00:be:94:e4",
    "hostname": "ubh1-2",
    "client-id": "01:52:54:00:be:94:e4",
    "expiry-time": 1687900286
  },
  {
    "ip-address": "192.168.122.56",
    "mac-address": "52:54:00:9d:cb:a8",
    "hostname": "ubh1-2",
    "client-id": "01:52:54:00:9d:cb:a8",
    "expiry-time": 1687902550
  }
]
```