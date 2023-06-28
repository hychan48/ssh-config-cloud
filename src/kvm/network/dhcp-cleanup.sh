#!/bin/bash
# currently has 5...
# restarting seems easiest...
exit 0

# Confirm files
tree /var/lib/libvirt/dnsmasq/
cat /var/lib/libvirt/dnsmasq/virbr0.macs # comes back on vm start
cat /var/lib/libvirt/dnsmasq/virbr0.status # updates when net-start
rm /var/lib/libvirt/dnsmasq/virbr0*

virsh net-dhcp-leases default # totally misalligned...
virsh net-define --file default.xml # not net-create
virsh net-undefine --network default # destroys, wont work if transiet. i.e net-create only for define

virsh net-destroy --network default # stops
virsh net-start default

virsh shutdown ubh1-1
virsh start ubh1-1

virsh net-start --network default
virsh net-dhcp-leases default
dig hpe-01.hpe1.localdomain +short # 127.0.1.1, which is what i hardcoded
dig +short ubh1-1.hpe1.localdomain @192.168.122.1
dig +short ubh1-1.hpe1.localdomain
dig ubh1-1.hpe1.localdomain

systemctl restart systemd-resolved
resolvectl status virbr0
resolvectl status eno1


dig +short myhost @192.168.122.1
dig +short myhost.hpe1.localdomain @192.168.122.1
dig +short myhostalias.hpe1.localdomain @192.168.122.1
dig +short kvmhost.hpe1.localdomain @192.168.122.1
dig +short kvm.hpe1.localdomain @192.168.122.1
dig +short hpe-01.amd.com @192.168.122.1 #

tree /etc/systemd/network -L 2
cat /etc/systemd/resolved.conf

# sample...
## backup bfore changing / trying anything
sudo systemd-resolve --interface wlp2s0 --set-dns 192.168.88.22 --set-domain yourdomain.local
# localOnly: yes is for something else
# find resolvectl settings


# https://github.com/systemd/systemd/issues/18761

virsh net-list --all
virsh net-dumpxml default

virsh net-create --file default.xml # name inside of xml.. so careful
# nano - can add hostname here...
# kvm will always python dependency... especially with virt-manager
EDITOR=tee virsh net-edit default # use tee? might as well just re-create it
# virsh net-edit default
:`
<network />
`
# get rid of that other file... why is it still there?

apt install nmap -y
nmap -e virbr0 -sP -n 192.168.122.0/24 > nmap.txt
# get ip
dig ubh1-2 @192.168.122.1 +short
virsh net-dhcp-leases default
cat /var/lib/libvirt/dnsmasq/virbr0.status #virs
cat /var/lib/libvirt/dnsmasq/virbr0.macs #
virsh domifaddr "ubh1-1"
virsh domifaddr "ubh1-2"

# might be best to just axe em
virsh net-destroy <network-name>
virsh net-start <network-name>

# For Linux guests, you can use dhclient or nmcli:
qemu-guest-agent

systemctl status qemu-guest-agent
systemctl restart qemu-guest-agent

ip neigh

# currently has two ubh1-2. but that one actually works.
#https://wiki.libvirt.org/Networking.html#id5
virsh net-update

# command is one of "add-first", "add-last", "add" (a synonym for add-last), "delete", or "modify".
virsh net-update default add ip-dhcp-host \
      "<host mac='52:54:00:00:00:01' \
       name='bob' ip='192.168.122.45' />" \
       --live --config

# doesnt seem to do anything though...
virsh net-dumpxml --inactive --network default
virsh net-dumpxml --network default
apt install xmlstarlet -y
xmlstarlet ed -s '//network' -t elem -n 'mac' -v '52:54:00:f9:cf:e2'

virsh net-update default add-last --xml "$(xmlstarlet ed -s '//network' -t elem -n 'mac' -v '52:54:00:f9:cf:e2' <(virsh net-dumpxml default))" --live --config

xmlstarlet ed -s '/' -t elem -n 'network' -v '' \
  -s 'network' -t elem -n 'name' -v 'mynetwork' \
  -s 'network' -t elem -n 'bridge' -v 'br0' \
  -s 'network' -t elem -n 'forward' -v 'bridge' \
  -s 'network' -t elem -n 'ip' -v '' \
  -s 'network/ip' -t elem -n 'address' -v '192.168.1.0' \
  -s 'network/ip' -t elem -n 'netmask' -v '255.255.255.0' \
  -s 'network' -t elem -n 'dhcp' -v '' \
  -s 'network/dhcp' -t elem -n 'range' -v '' \
  -s 'network/dhcp/range' -t elem -n 'start' -v '192.168.1.100' \
  -s 'network/dhcp/range' -t elem -n 'end' -v '192.168.1.200' \
  -s 'network' -t elem -n 'mac' -v '52:54:00:f9:cf:e2'

xmlstarlet sel -t -c "network" -v /dev/null
xmlstarlet sel -t -c "network" -n -v "" \
  -t -o "<name>mynetwork</name>" -n \
  -t -o "<bridge>br0</bridge>" -n \
  -t -o "<forward>bridge</forward>" -n \
  -t -c "ip" -n \
  -t -o "<address>192.168.1.0</address>" -n \
  -t -o "<netmask>255.255.255.0</netmask>" -n \
  -t -c "dhcp" -n \
  -t -c "range" -n \
  -t -o "<start>192.168.1.100</start>" -n \
  -t -o "<end>192.168.1.200</end>" -n \
  -t -o "<mac>52:54:00:f9:cf:e2</mac>" -n


xmlstarlet sel -t -c "network" -v "" -n

# xml hello world example
cat > hello.xml <<< EOF
<?xml version="1.0" encoding="UTF-8"?>
<root>
    <message>Hello, World!</message>
</root>
EOF
# selects xpath expression, wth is -t
xmlstarlet sel -t -v "/root/message" hello.xml
# sel: This is the select command, which allows you to select data from the XML file.
# -t: This option specifies that a template is being used.
# -v: This option specifies the value of the following XPath expression.
# "/root/message": This is the XPath expression that specifies the location of the data you want to select. In this case, it's selecting the text inside the <message> tag.
# hello.xml: This is the XML file that the command is being run on.

