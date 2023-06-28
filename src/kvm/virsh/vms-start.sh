#!/bin/bash
# turn on all --inactive
# todo add params / flags etc.
# VMS=("ub1" "ub2" "win2k19-1" "win2k19-2")
VMS=()
while IFS= read -r line; do
  if [[ -n "$line" ]]; then  # Check if line is not empty
    VMS+=("$line")
  fi
done < <(virsh list --inactive --name)

# echo "${VMS[0]}"  # First element
# echo "${VMS[1]}"  # Second element
# exit 0

echo $VMS
for VM in "${VMS[@]}"
do
  # loop
   echo Starting vm $VM
   virsh start $VM
done
