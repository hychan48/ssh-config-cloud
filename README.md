# SSH Config Cloud
Notes and templates for using SSH Config. KVM &amp; Hyper-V host to Windows &amp; Ubuntu with default NAT Tunneling

 * [Searchable Docs](https://hychan48.github.io/ssh-config-cloud/)

<!-- table of contents essentially for now -->
<!-- need to add in the content slowly, too much content -->


# Basic Inject
## Debian / Ubuntu
```bash
# list
# grep line after id
curl -L https://api.github.com/users/hychan48/keys

```


# General Provisioning
* Hostname / Computer Name / VM Name
1. User Accounts
  * sudoers / root / admin
2. SSH Server / Keys
3. Networking
  * DNS
  * DHCP
  * NAT
  * Optional:
    * Routing (only if multiple nics)
      * metric in routing / gateway / rules
      * kvm host hostname.
    * VPN
    * Firewall
    - probably best to check and report device names
* File Transfering
  * curl
  * wget
  * scp
  * rsync
  * sftp
  * croc github
    * scoop / winget
    * also blaze?
  * might need to use clipboard typing for some
  * mounting (look into read only - other special options)
    * provided by kvm / hyper-v
    * like create an iso type of thing
    * brasero / gnome-disk-utility
  <!-- * sshfs
  * smb
  * nfs
  * ftp
  * tftp
  * http
  * https
  * git
  * github
  * gitlab
  * bitbucket
  * etc. -->
* Remote Desktop
* Check for Updates
* https://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/amd64/fish_3.6.1-1_amd64.deb
* auto install type of thing
* package dependant, but opensuse has a certain naming convention

# Development
```bash
# fish
# 2. `-O` means write output to a local file named like the remote file we get (the URL in our case).
# might need -L for redirect
URL="https://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/amd64/fish_3.6.1-1_amd64.deb";
curl -OL $URL && sudo dpkg -i $(basename $URL) && sudo apt-get install -f
# had to run apt --fix-broken install
# set default shell
chsh -s /usr/bin/fish
# xming? or mobaxterm
```
```bash
mklink /H "C:\Users\Jason\AppData\Roaming\MobaXterm\home\.ssh\config" "C:\Users\Jason\.ssh\config"

junction.exe "C:\Users\Jason\AppData\Roaming\MobaXterm\home\.ssh\config" "C:\Users\Jason\.ssh\config"

# actually... maybe better to link the folders
https://stackoverflow.com/questions/894430/creating-hard-and-soft-links-using-powershell

cmd /c mklink /H "C:\Users\Jason\AppData\Roaming\MobaXterm\home\.ssh\config" "C:\Users\Jason\.ssh\config"

# soft link is enough for mobaxterm / mabe link with cygwin as well
# todo use env variables for reusability
cmd /c mklink "C:\Users\Jason\AppData\Roaming\MobaXterm\home\.ssh\config" "C:\Users\Jason\.ssh\config"
```


# Tools
# VNC
* [RealVNC Viewer](https://www.realvnc.com/en/connect/download/viewer/)
* [TightVNC](https://www.tightvnc.com/download.php)

# Development Utilities
* [Visual Studio Code](https://code.visualstudio.com/)
* [Visual Studio Code SSH](https://code.visualstudio.com/docs/remote/ssh)
* SSH Config Man Page

## Mac
* VSCode
<!-- * iTerm2? tmux? -->
* Karabiner Elements
* NoMachine
<!-- * TouchBarServer? -->

## Linux
<!-- todo add links -->
* apt install inetutils-tools dnsutils -y
  * comes with ping, traceroute, etc. dig, nslookup, etc. nmap?
<!-- * nnmap? add docs -->
<!-- * apt iproute2? or iputils-ping? -->
* dig which is in dnsutils?
* pingarp (arping)? / wireshark etc.
* net-tools? (ifconfig) / iproute2? (ip)
* zsh / fish
  * fish is legit
* ip addr show
* ip route show
* ip rule show
* /etc/resolve.conf / systemd-resolve --status / resolvectl status (ub22+)
* wget / curl


### KVM
* virsh auto-completion / alias etc.
* xml editors / helpers
* mamba / conda can be useful
  * it's like a package manager made in python. not just for python
  * also some other pipx or something

### Hyper-V
* AHK for clipboard typing. ctrl send is broken though for linux. but i have a script

## Windows
* cygwin? pacman? mobaxterm? moba is cygwin...
  * rsync is in cygwin. but add manually
    * also cygwin is isolated i believe. so need to copy files into it / junction
  <!-- * bunch of net tools... interesting -->
  <!-- * what is debuginfo? -->
* VSCode / Pwsh Macro or other terminal for exiting ssh
  * baincd.copy-path-unixstyle
  * path extention converter. kinda like what i was making
* OpenSSH Repo with installer
* WinGet
* SysInternals 
  * pslist
  * pskill
  * tcpview
  * autologon.exe
  * psexec
    * `query session` and other ways to get session id (-i 1) is common
  * *acceptEula script*
* VSCode shortcuts / macros and extentions
* AHK
* Task Scheduler Helper. github repo somewhere
* Nirsoft
  * NetworkInterfacesView.exe
  * MultiMonitorTool.exe (For Multi-Monitor)
  * RegFromApp.exe
  * KeyBoardStateView.exe
  * a lot more
* Chromium Portable
  * chocolatey / scoop to install
  * to ensure it's portable / snapshot to doesnt break for testing



## Windows UX
* todo. maybe merge from other repo
* defn. my Profiles.ps1 and SSH Config settings

# Misc
* 7zip
* Everything 1.5.0.1248
  * It's much faster than Windows Search
