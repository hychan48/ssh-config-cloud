# SSH Config Cloud
Notes and templates for using SSH Config. KVM &amp; Hyper-V host to Windows &amp; Ubuntu with default NAT Tunneling

How to access KVM / Hyper-V
With SSH Config, tab completion<sup>[1](https://github.com/gianlucaborello/aws-ssh-config)</sup>


# Setup SSH keys
```bash
ssh-keygen -t ed25519

# follow prompt
# default

echo ~/.id_ed25519
echo ~/.id_ed25519.pub

# Advanced
# obscure the hostname
ssh-keygen -t ed25519 -C "deb"
```

# GitHub Public Keys
`https://github.com/<username>.keys`
`https://github.com/hychan48.keys`


```bash
# Copy Pub keys from github
mkdir -p ~/.ssh/
chmod -R 600 ~/.ssh/
```
# on windows, ed25519 

# Ubuntu / Debian
<!-- [a relative link](other_file.md) -->



# Setup SSH Keys
<!-- [a relative link](other_file.md) -->


# Generate Powershell
* mshome.net (default)
* 
## Install SSH
[Microsoft's Powershell Instructions](https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=powershell#install-openssh-for-windows)

```ps1
# Manually
# https://github.com/PowerShell/Win32-OpenSSH/releases/latest
# Download msi and run then run firewall rules. i.e.
# Download Url... end as filename w/o parsing header
# https://stackoverflow.com/a/44475621
Function Get-Url {
  param ( [parameter(position=0)]$uri )
  invoke-webrequest -uri "$uri" -outfile $(split-path -path "$uri" -leaf)
}
Get-Url("https://github.com/PowerShell/Win32-OpenSSH/releases/download/v9.2.2.0p1-Beta/OpenSSH-Win32-v9.2.2.0.msi")
msiexec /i path to OpenSSH-Win64-v9.2.2.0.msi
#... firewall rules here


```
```ps1
# misc
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -f
Get-ExecutionPolicy

# irm can use proxy
irm get.scoop.sh -Proxy 'http://<ip:port>' | iex

# https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/deploy-windows-on-a-vhd--native-boot?view=windows-11


# for gen 1
# https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/boot-to-vhd--native-boot--add-a-virtual-hard-disk-to-the-boot-menu?view=windows-11
Attach <vdisk>


cd "D:\hyperV\ub1\Virtual Hard Disks"
diskpart
# create vdisk file="D:\hyperV\ub1\Virtual Hard Disks" maximum=25600 type=fixed
select vdisk file="D:\hyperV\ub1\Virtual Hard Disks\ub1.vhdx"
Attach vdisk

# for existing.. i see 1
# list partition
select partition 3
assign letter=v

# dont think this applies to ubuntu... because it's not ntfs...
msconfig.exe

# msconfig.exe
V:\
cd v:\windows\system32
bcdboot v:\windows /s S: /f UEFI


# gen 1.. so
bcdboot v:\windows /s S: /f UEFI



V for Vm, S for System.

list vdisk
exit


#
Partition ###  Type              Size     Offset
  -------------  ----------------  -------  -------
  Partition 1    Unknown           1024 KB  1024 KB
  Partition 2    Unknown           2048 MB  2048 KB
  Partition 3    Unknown            124 GB  2050 MB

```

## WSL Debian
* localdomain
* 172.17.107.87/28
* `hostnamectlr` fails
# Generate Shell

# Export Display
```bash
# SSH
## Remember to use capital
export DISPLAY=localhost:10.0 # ssh
```

## Microsoft SysInternals
[System Internals](https://learn.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite)
* psexec
* pskill
* rdcman
* autologon.exe


