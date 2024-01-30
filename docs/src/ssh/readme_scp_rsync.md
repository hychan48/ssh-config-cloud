# SCP / Rsync Behavior
## Background
* Had issues with duplicate folders when using the command more than once or not at all
* Was aware of the source vs source/ but hard. Syntax doesn't feel intuitive
* windows / posix paths. i.e. ~/home
## Goal 
* ssh copy folder from source '~/a/' to destination '~/tmp/a/'
    * [Expected Folder Structure](##Expected\ Folder\ Structure)
    <!-- fixme -->
    <!-- * Expected Folder Structure -->
    <!-- * [Expected Folder Structure](##Expected Folder Structure) -->

## Summary of Findings
1. Single quotes and use $HOME
    * $HOME is pretty universel. case-senstive $HOME
        1. except in CMD. and psexec -s. 
            * so don't use $HOME better to use full path to user
        2. psexec. probably use '$env:PUBLIC' -> `C:\Users\Public`
    * PWSH supports regular slashes '/' in paths
2. Create /Ensure the destination folder exists on the destination
3. Windows PSEXec
* linux to linux -> rsync
    <!-- * assuming rsync is on both. not sure if needed -->
* linux to windows -> scp
    * assuming pwsh is defaulted shell of ssh
```bash
##!/bin/bash
## Examples for both Windows and Linux. and no duplicates if ran multiple times
scp -r $HOME/a remotehost:'$HOME/tmp'
scp -r $HOME/a win11:'$HOME/tmp'
## If $HOME/tmp already exists
## Single quotes important!

##recommended... for windows psexec hardcode the path
scp -r $HOME/a win11:'$Env:PUBLIC/tmp'
scp -r $HOME/a win11:'%PUBLIC%/tmp' ## unverified. might work if cmd is default ssh shell


## Example for Linux
rsync -a ~/a remotehost:~/tmp
## ~/tmp will be created if it doesnt exist
## Single quotes important!
##--------------------------------------------------
## Create folders if not exist / exists - Single Quotes important!
## avoid ssh to run the command.dont recommend using ssh if you dont have to. overhead to create connection to run a single command
ssh remotehost 'mkdir -p $HOME/tmp;tree $HOME/tmp' | grep --color='auto' "/"
ssh win11 'New-Item -Path "$HOME/tmp" -ItemType Directory -Force -ErrorAction SilentlyContinue ; Get-ChildItem -Path "$HOME/tmp"'

## Remove Folders Example
ssh remotehost 'rm -rf "$HOME/tmp";tree "$HOME/tmp"' | grep "/"
ssh win11 'Remove-Item -Path "$HOME/tmp" -Recurse -Force -ErrorAction SilentlyContinue ; Get-ChildItem -Path "$HOME/tmp" -ErrorAction SilentlyContinue;write-host 'dir deleted''
```

## Rsync Windows Cygwin
:::code-group
```bash
# https://akliang.medium.com/how-to-rsync-directly-into-a-windows-10-machine-using-openssh-not-cygwin-or-wsl-cbbadff95712
rsync -avP --rsync-path='wsl rsync' <file_to_send> <username>@<host_ip>:<path>
```
```bash
# https://superuser.com/questions/1734844/cygwin-rsync-cannot-run-outside-of-cygwin-terminal
C:\Cygwin\bin\rsync.exe -e "C:\Cygwin\bin\ssh.exe" source_file destination.

# interesting... maybe because i do not have it?
ls c:/cygwin64/bin/ssh.exe
```
* vite-press-docs.git/ pwsh-alias-exp.ps1
* docs_readme_cygwin.md
:::

## Test Environment
* localhost is a linux host / source
* remotehost is a linux ssh destination host (same machine as localhost)
* win11 is a windows ssh destination host
    * pwsh is the default shell
* ssh config is configured properly
#### Expected Folder Structure
```bash
## Source Folder
/root/a
└── a1
    └── a2
        └── a3
            └── a4.txt

3 directories, 1 file
## Expected Destination Folder after copy
/root/tmp
└── a
    └── a1
        └── a2
            └── a3
                └── a4.txt
4 directories, 1 file
```
###### Errors
```bash
##--------------------------------------------------
DExists: ~/tmp: scp -r ~/a localhost:~/tmp
OK: scp -r ~/a localhost:~/tmp
OK: scp -r ~/a localhost:~/tmp
DNE   : ~/tmp : scp -r ~/a localhost:~/tmp
ERROR: scp -r ~/a localhost:~/tmp
/root/tmp
└── a1
    └── a2
        └── a3
            └── a4.txt

3 directories, 1 file
ERROR: scp -r ~/a localhost:~/tmp
/root/tmp
├── a
│   └── a1
│       └── a2
│           └── a3
│               └── a4.txt
└── a1
    └── a2
        └── a3
            └── a4.txt

7 directories, 2 files
##--------------------------------------------------

## Windows if tmp didnt exist and ran mulitple times
FullName                              
--------                                    
C:\Users\Administrator\tmp\a                
C:\Users\Administrator\tmp\a1               
C:\Users\Administrator\tmp\a\a1             
C:\Users\Administrator\tmp\a\a1\a2          
C:\Users\Administrator\tmp\a\a1\a2\a3       
C:\Users\Administrator\tmp\a\a1\a2\a3\a4.txt
C:\Users\Administrator\tmp\a1\a2            
C:\Users\Administrator\tmp\a1\a2\a3         
C:\Users\Administrator\tmp\a1\a2\a3\a4.txt  
```

#### Sample Execution for Windows
```bash
## Delete
## create
## scp
## check
ssh win11 'Remove-Item -Path "$HOME/tmp" -Recurse -Force -ErrorAction SilentlyContinue ; Get-ChildItem -Path "$HOME/tmp" -ErrorAction SilentlyContinue;write-host 'dir deleted''
ssh win11 'New-Item -Path "$HOME/tmp" -ItemType Directory -Force -ErrorAction SilentlyContinue ; Get-ChildItem -Path "$HOME/tmp"'
scp -r $HOME/a win11:'$HOME/tmp'
scp -r $HOME/a win11:'$HOME/tmp' ## and again
ssh win11 'Get-ChildItem -Path "$HOME/tmp" -Recurse -ErrorAction Stop | Select-Object -Property FullName -First 10'
```
```txt
FullName
--------
C:\Users\Administrator\tmp\a
C:\Users\Administrator\tmp\a\a1
C:\Users\Administrator\tmp\a\a1\a2
C:\Users\Administrator\tmp\a\a1\a2\a3
C:\Users\Administrator\tmp\a\a1\a2\a3\a4.txt
```
## Appendix
#### Common Pitfalls



<!-- ## Appendix -->
* From man pages:
```
A trailing slash on a source path means "copy the contents of this directory". Without a trailing slash it means "copy the directory". DESTINATION Destination is the directory that source is copied to. If the source argument ends with a trailing slash, the contents of the source directory are copied into the destination directory. Otherwise, the source directory itself is copied into the destination directory. This behavior can be changed using the --recursive (-r) option.
```

#### Full log - More details in
<!-- todo add workflow or something -->
* [logfile.log](src\scp_rsync\logfile.log)
* look at generate_scp_rsync_log.sh for more details

## Dependencies
* [Get-Tree.ps1](src\debug_utils\ps1\Get-Tree.ps1)
    * in profiles
```bash
##!/bin/bash
sudo apt install tree rsync scp -y
## Tested on Debian 11
## rsync -V ## 3.2.3
## sudo apt install tree rsync scp batcat -y
## assuming ssh is installed

```

#### Utility Commands
```bash
#### Raw commands
ssh remotehost 'rm -rf "$HOME/tmp"'
ssh win11 'Remove-Item -Path "$HOME/tmp" -Recurse -Force -ErrorAction SilentlyContinue' 



## todo
## find -e 
##Get-tree has some cmd to check for path
## verify multiple mkdir -p for windows
ssh win11 'New-Item -Path "$HOME/tmp/a" -ItemType Directory -Force -ErrorAction SilentlyContinue ; Get-Tree "$HOME/tmp"'
```
<!-- 
ssh remotehost 'rm -rf $HOME/tmp'
tree $HOME/tmp
ssh win11 'Remove-Item -Path "$HOME/tmp" -Recurse -Force;Get-ChildItem -Path "$HOME/tmp"'
ssh win11 'Remove-Item -Path "C:\path\to\directory" -Recurse -Force'

 -->
<!-- ```bash
## debug
mkdir -p $HOME/tmp
New-Item -Path "$HOME" -ItemType Directory -Force
``` -->
<!-- #### Assumptions -->
<!-- * local linux host. ssh targets are linux or windows  -->
<!-- * ssh config is configured properly -->
<!-- * ssh,rsync is configured propertly on both systems -->
<!-- todo. check if rsync is required on both systems / cygwin-->


## Folder Name Change
* as of OpenSSH 9.0. scp uses sftp under the cover
* Paramiko client as mentioned, is bundled with a sftp client
* https://www.linuxadictos.com/en/openssh-9-0-llega-con-sftp-en-lugar-de-scp-mejoras-y-mas.html##:~:text=9%20on%20Linux%3F-,Main%20new%20features%20of%20OpenSSH%209.0,host%2C%20which%20creates%20security%20issues.
    * scp 'deprecated' in favor of sftp
* apparently curl can use sftp... interesting
```bash
## Renames rasa_deps to rasa / folder name was changed
rsync -r '/home/rasa/rasa_deps/' {{@_host.loginprefix}}:/root/rasa ## this works in rsync, note because the 

## It's impossible in SCP to do it in one simple command - according to google
#### i think i agree
## Next Best thing for us
scp -r /home/rasa/rasa_deps/dependencies {{@_host.loginprefix}}:/root/rasa ## this one works from trial an error
```

```yaml
tmp:
  - |
    print('hi')
    def tmp:
      print('bla')
```