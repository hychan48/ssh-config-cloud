#!/bin/bash
# or maybe zsh...
# using tree
mkdir -p ~/a/a1/a2/a3
mkdir -p ~/b/b1/b2/b3
touch ~/a/a1/a2/a3/a4.txt
touch ~/b/b1/b2/b3/b4.txt
tree ~/a
tree ~/b


mkdir -p ~/tmp
rm -rf ~/tmp

scp -r ~/a ~/tmp # duplicate
scp -r ~/a/ ~/tmp # duplicate
scp -r ~/a/ ~/tmp/ # duplicate
scp -r ~/a ~/tmp/ # duplicate


# scp -r /path/to/source/ user@remote:/path/to/destination
rm -rf ~/tmp
scp -r ~/a/** ~/tmp/ # apparently this shoudl work?
scp -r ~/a/* ~/tmp/ # apparently this shoudl work?
tree ~/tmp
scp -r ~/a/ ~/tmp
tree ~/tmp

# try copying stuff into ~/tmp

# que?
shopt -s dotglob
scp -r /path/to/source/* user@remote:/path/to/destination/
shopt -u dotglob


# Sample duplicate
rm -rf ~/tmp
tree ~/a # sample directory
scp -r ~/a ~/tmp
tree ~/tmp # expected
scp -r ~/a ~/tmp  # duplicated...
tree ~/tmp # duplicated

# how to not get the duplicated on repeated calls to scp?
# so have to cd?. okay this works

rm -rf ~/tmp
mkdir ~/tmp
tree ~/a # sample directory
cd ~/tmp
scp -r ~/a .
tree ~/tmp # expected
scp -r ~/a .
tree ~/tmp # will not be duplicated

rsync --help


cd ~/;rm -rf ~/tmp;mkdir ~/tmp
tree ~/a # sample directory
tree ~/tmp # sample directory

# trailing slash doesnt copy a directory. i.e rename
rsync -av ~/a/ ~/tmp/ #rsync -av means archive and verbose. 
rsync -av ~/a/ ~/tmp # these two work together

# these two work together
# sending incremental file list...
# trailing slash is more like spread
rsync -av ~/a ~/tmp/ #rsync -av means archive and verbose. 
rsync -av ~/a ~/tmp #this one was slightly diff. this one copied extra shit

# both commands do the same thing because it's directory?
# ending / means copy contents of directory
tree ~/tmp # expected
rsync -av ~/a/ ~/tmp/
tree ~/tmp # will not be duplicated

# Subshells and pushd popd
# push directory...
(cd /path/to/directory && command)
pushd /path/to/directory; command; popd



## powershell commands
Push-Location -Path "C:\Some\Directory" 
# Execute your commands here
Pop-Location


# rsync should also create paths?

If you're using a KVM host with a Windows guest, you have a few options for transferring files:

1. **SCP/SSH:** If you have an SSH server installed on the Windows guest (for example, OpenSSH), you can use SCP or SSH for file transfers.

2. **SMB/CIFS:** Windows natively supports SMB/CIFS, and Linux can mount SMB/CIFS shares. This would allow file sharing between the KVM host and Windows guest.

3. **Virtio-serial:** KVM/QEMU allows for the creation of virtual serial devices with the virtio-serial driver. You can set up a virtio-serial channel and then use a tool like socat or netcat to transfer files.

4. **Guestfish:** Guestfish is a tool that allows you to mount a disk image and manipulate the file system inside the disk image. This could be used for copying files to and from the disk image.

5. **RDP and Shared Clipboard:** If you're using a graphical interface, you can use RDP (Remote Desktop Protocol) to connect to the Windows guest from the KVM host. Then you can copy and paste files using the shared clipboard.

The method you choose depends on your specific requirements, the network and security configuration, and what software is installed on the Windows guest. The above methods are all alternatives to using `scp`. If you want to use `scp`, an SSH server like OpenSSH would need to be installed on the Windows guest.