#!/bin/bash
virsh list
qemu-img info /var/lib/libvirt/images/qcows/vms-ub/ub5.qcow2
qemu-img resize /var/lib/libvirt/images/qcows/vms-ub/ub5.qcow2 +40G
qemu-img info /var/lib/libvirt/images/qcows/vms-ub/ub5.qcow2 |grep "virtual size"
virsh start ub5
sudo virsh blockresize ub5 /var/lib/libvirt/images/qcows/vms-ub/ub5.qcow2 50G