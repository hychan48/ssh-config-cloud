# WSL 2
## Common

:::code-group
```powershell [main]
wsl.exe --list --verbose
# root user can access Windows
wsl.exe --distribution Debian --user root
wsl.exe --distribution Ubuntu-22.04 --user root
```
```powershell [default debian]
wsl.exe --setdefault Debian
debian.exe config --default-user root
```
```powershell [default ub2204]
wsl.exe --setdefault Ubuntu22.04
ubuntu2204.exe config --default-user ubuntu
```
```powershell [default ub2004]
wsl.exe --setdefault Ubuntu20.04
ubuntu2004.exe config --default-user ubuntu
```
```powershell [misc]
wsl.exe --distribution Debian --user deb
wsl.exe --distribution Ubuntu-22.04 --user ubuntu
```
:::
## Exec - Tree
```powershell
wsl.exe -- tree . -L 1
```
* sdfsdf
<!-- wsl.exe -e tree .
wsl.exe -e tree . -L 1
wsl.exe -- tree . -->
:::details
* inside of wsl... with fish / zsh you'l get color...
```powershell
-- exec, -e <CommandLine> Execute without $SHELL
-- Pass the remaining command line as is.
# %LOCALAPPDATA%\Packages\
# WSL Set Default
wsl --setdefault docker-desktop-data
wsl --setdefault Debian
wsl --setdefault Ubuntu-22.04

# Debian Default user
debian.exe --help
debian.exe config --default-user root
debian.exe config --default-user deb
```
:::
<!-- might be easier to have it in one file and reference it... and or auto generate  -->
## SSHD Restart
```bash
#!/bin/bash - inside WSL Ubuntu
/etc/init.d/ssh restart
```


## Shutdown / Delete
:::code-group
```powershell [shutdown]
wsl.exe --shutdown ub22
wsl.exe --shutdown #all
```
```powershell [force shutdown]
wsl.exe --terminate ub22

```
```powershell [unregister-undefine-remove]
wsl.exe --unregister ub22 # removes the vmdx...
```
:::



## VM Tools
* convert img to vhdx
* virt-customize etc.
* qemu-guest-agent installer

## Misc
::: code-group
```powershell 
wsl.exe --list --verbose
```
```txt [name-state-version.log]
  NAME                   STATE           VERSION
* docker-desktop-data    Stopped         2
  Ubuntu-22.04           Stopped         2
  Debian                 Stopped         2
```
```powershell 
wsl.exe --list
```
```powershell 
wsl.exe --list --all
```
:::

## Duplicate WSL
```powershell [duplicate-vm.ps1]
wsl.exe --install 'Ubuntu-22.04'

wsl.exe --export 'Ubuntu-22.04' ub22.tar
wsl.exe --import ub22-1 $HOME/ub22-1 "ub22.tar"

# vhdx
wsl.exe --shutdown
wsl.exe --shutdown ub22-1
wsl.exe --export ub22-1 --vhd ub22-1.vhdx

# misc
netsh.exe winsock reset # get stuck sometimes
```

## NT to wsl.exe Posix Mount Path
* [win32-posix-path util](https://codeforwings.github.io/nuxt3-win32-posix-path/)
* cygwin
