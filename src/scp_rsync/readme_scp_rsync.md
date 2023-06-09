# SCP / Rsync Behavior
* For copying folders

# Background
* Had issues with duplicate folders when using the command more than once
* Was aware of the source vs source/ but hard. Doesn't feel intuitive

# Summary
* copy folder from source '~/a/' to destination '~/tmp/a/'
```bash
#!/bin/bash
# the actual syntax:
scp -r ~/a ~/tmp # no work...
scp -r ~/a ~/tmp
rsync -a ~/a ~/tmp
rsync -a ~/a ~/tmp/a
rm -rf ~/tmp
tree ~/tmp
# -a is -r with timestamps. --archive --recursive
# note, both scp and rsync only creates one folder
```
## Error / Wrong
```
```

# Details
* From man pages:
```
A trailing slash on a source path means "copy the contents of this directory". Without a trailing slash it means "copy the directory". DESTINATION Destination is the directory that source is copied to. If the source argument ends with a trailing slash, the contents of the source directory are copied into the destination directory. Otherwise, the source directory itself is copied into the destination directory. This behavior can be changed using the --recursive (-r) option.
```

# Dependencies
```bash
#!/bin/bash
sudo apt install tree rsync scp batcat -y
# Tested on Debian 11
# rsync -V # 3.2.3
```

# Folder Structure
```bash
/root/a
└── a1
    └── a2
        └── a3
            └── a4.txt

3 directories, 1 file
# Expected result after copy
/root/tmp
└── a
    └── a1
        └── a2
            └── a3
                └── a4.txt
4 directories, 1 file
```
# Highlights
