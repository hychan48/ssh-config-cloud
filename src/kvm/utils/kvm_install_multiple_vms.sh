# add to this project / append
# https://pve.proxmox.com/wiki/Qemu-guest-agent

yum install qemu-guest-agent

# proxmox? on both host and guest?
# * wow
apt-get install qemu-guest-agent -y
systemctl start qemu-guest-agent
systemctl enable qemu-guest-agent

## Channel device...
qemu-guest-agent 

# https://wiki.qemu.org/Features/GuestAgent
:```
<channel type="unix">
  <source mode="bind" path="/var/lib/libvirt/qemu/channel/target/domain-12-ub5/org.qemu.guest_agent.0"/>
  <target type="virtio" name="org.qemu.guest_agent.0" state="connected"/>
  <alias name="channel0"/>
  <address type="virtio-serial" controller="0" bus="0" port="1"/>
</channel>
```

https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-using_the_qemu_guest_virtual_machine_agent_protocol_cli-libvirt_commands
virsh domfsinfo --domain ub5
virsh domifaddr ub5 --source agent
virsh domifaddr ub1 --source agent
virsh domifaddr ub5
## windows