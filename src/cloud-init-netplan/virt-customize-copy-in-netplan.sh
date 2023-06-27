#!/bin/bash
# todo add the sciprt path. note file to directory
# can't be live! also must be .yaml not .yml. use netplan get to verify
echo "network: {config: disabled}" > "99-disable-network-config.cfg"
virt-customize -d ub2 --copy-in ./99-kvm-netplan.yaml:/etc/netplan/
virt-customize -d ub2 --copy-in ./99-disable-network-config.cfg:/etc/cloud/cloud.cfg.d
virt-customize -d ub2 --copy-in ./99-disable-network-config.cfg:/etc/cloud/cloud.cfg.d

virt-customize -a /mnt/vdishare/VirtDriverV2/rasa_vdishare/deps_copy/vm-lnx/cloud-init-qcow2s/ub2.qcow2 --copy-in ./99-disable-network-config.cfg:/etc/cloud/cloud.cfg.d
virt-customize -a /mnt/vdishare/VirtDriverV2/rasa_vdishare/deps_copy/vm-lnx/cloud-init-qcow2s/ub2.qcow2 --copy-in ./99-kvm-netplan.yaml:/etc/netplan/
virt-customize -a /mnt/vdishare/VirtDriverV2/rasa_vdishare/deps_copy/vm-lnx/cloud-init-qcow2s/ub2.qcow2 --delete /etc/netplan/50-cloud-init.yaml


# https://netplan.readthedocs.io/en/stable/netplan-yaml/#properties-for-physical-device-types

# Let's try injecting
# netplan
# --dry-run
#  virt-sysprep [--options] -d domname
echo "network: {config: disabled}" > "99-disable-network-config.cfg"
virt-customize -d ub2 --copy-in ./99-kvm-netplan.yml:/etc/netplan/
virt-customize -d ub2 --copy-in ./99-disable-network-config.cfg:/etc/cloud/cloud.cfg.d

# cant be on
# virt-customize -d ubh1-1 --copy-in /root/jc_dev/99-kvm-netplan.yml:/etc/netplan/
# (cd /etc/cloud/cloud.cfg.d/;echo "network: {config: disabled}" > 99-disable-network-config.cfg)
:'
virsh start ub2
virsh net-dhcp-leases default
virsh list --all
virsh list
virsh shutdown ub2
virsh start ub2
'
