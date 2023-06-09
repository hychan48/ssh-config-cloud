#!/bin/zsh
# Initialize Folders
function InitializeDummyFolders(){
    mkdir -p ~/a/a1/a2/a3
    # mkdir -p ~/b/b1/b2/b3
    touch ~/a/a1/a2/a3/a4.txt
    # touch ~/b/b1/b2/b3/b4.txt
    tree ~/a
    # tree ~/b
}
InitializeDummyFolders
# echo and log to file. use less for console coloring or highlight or bat (better cat)
# vscode doesnt need the script -efq -c...
function logecho() {
    echo "$@" | tee -a logfile.log
}
rm -f logfile.log

# should maybe tee? i just want to count to verify
# Want to copy ~/a to ~/tmp/a or just use realpath
# https://linux.die.net/man/1/test
# stdbuf  to persist color
function printAndEvaluateDestinationDir(){
    # script -efq -c "tree ~/tmp" | tee -a logfile.log
    tree ~/tmp | tee -a logfile.log | grep "4 directories, 1 file" && logecho "OK" ||logecho "ERROR"
    # better error checking might be 
    # 4 directories, 1 file
    # tree ~/tmp | tee -a tmp.log |grep "4 dir..."
    # test -e ~/tmp/a/a1/a2/a3/a4.txt && logecho "OK" ||logecho "ERROR" # good
    # test -e ~/tmp/a/a1/a2/a3/a4.txt && logecho "OK" ||logecho "ERROR" # good
    # test -e ~/tmp/a1/a2/a3/a4.txt && logecho "ERROR" || logecho "OK" # bad
    # { myvar=$(mycommand | tee /dev/fd/3 | grep keyword); } 3>&1
    # https://serverfault.com/questions/989742/tee-and-assigning-to-variable
}
# maybe have expected fail and expected pass
# unalias recreateDestinationDir
# unalias rmDestinationDir
alias recreateDestinationDir='rm -rf ~/tmp && mkdir ~/tmp'
alias rmDestinationDir='rm -rf ~/tmp'
# can consolidate these into a function. this is more verbose
#--------------------------------------------------
# recreateDestinationDir
# One
recreateDestinationDir
rsync -a ~/a ~/tmp
printAndEvaluateDestinationDir
# Two
recreateDestinationDir
rsync -a ~/a ~/tmp
rsync -a ~/a ~/tmp
printAndEvaluateDestinationDir
# rmDestinationDir
# One
rmDestinationDir
rsync -a ~/a ~/tmp
printAndEvaluateDestinationDir
# Two
rmDestinationDir
rsync -a ~/a ~/tmp
rsync -a ~/a ~/tmp
printAndEvaluateDestinationDir
#--------------------------------------------------
#--------------------------------------------------
# recreateDestinationDir
# One
recreateDestinationDir
rsync -a ~/a ~/tmp/a
printAndEvaluateDestinationDir
# Two
recreateDestinationDir
rsync -a ~/a ~/tmp/a
rsync -a ~/a ~/tmp/a
printAndEvaluateDestinationDir
# rmDestinationDir
# One
rmDestinationDir
rsync -a ~/a ~/tmp/a
printAndEvaluateDestinationDir
# Two
rmDestinationDir
rsync -a ~/a ~/tmp/a
rsync -a ~/a ~/tmp/a
printAndEvaluateDestinationDir
#--------------------------------------------------
#--------------------------------------------------
# recreateDestinationDir
# One
recreateDestinationDir
rsync -a ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
# Two
recreateDestinationDir
rsync -a ~/a/ ~/tmp/a
rsync -a ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
# rmDestinationDir
# One
rmDestinationDir
rsync -a ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
# Two
rmDestinationDir
rsync -a ~/a/ ~/tmp/a
rsync -a ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
#--------------------------------------------------
#--------------------------------------------------
# recreateDestinationDir
# One
recreateDestinationDir
rsync -a ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
# Two
recreateDestinationDir
rsync -a ~/a/ ~/tmp/a
rsync -a ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
# rmDestinationDir
# One
rmDestinationDir
rsync -a ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
# Two
rmDestinationDir
rsync -a ~/a/ ~/tmp/a
rsync -a ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
#--------------------------------------------------
#--------------------------------------------------
# recreateDestinationDir
# One
recreateDestinationDir
scp -a ~/a/ ~/tmp
printAndEvaluateDestinationDir
# Two
recreateDestinationDir
rsync -a ~/a/ ~/tmp/a
rsync -a ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
# rmDestinationDir
# One
rmDestinationDir
rsync -a ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
# Two
rmDestinationDir
rsync -a ~/a/ ~/tmp/a
rsync -a ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
#--------------------------------------------------

# SCP
#--------------------------------------------------
# recreateDestinationDir
# One
recreateDestinationDir
scp -r ~/a ~/tmp
printAndEvaluateDestinationDir
# Two
recreateDestinationDir
scp -r ~/a ~/tmp
scp -r ~/a ~/tmp
printAndEvaluateDestinationDir
# rmDestinationDir
# One
rmDestinationDir
scp -r ~/a ~/tmp
printAndEvaluateDestinationDir
# Two
rmDestinationDir
scp -r ~/a ~/tmp
scp -r ~/a ~/tmp
printAndEvaluateDestinationDir
#--------------------------------------------------
#--------------------------------------------------
# recreateDestinationDir
# One
recreateDestinationDir
scp -r ~/a ~/tmp/a
printAndEvaluateDestinationDir
# Two
recreateDestinationDir
scp -r ~/a ~/tmp/a
scp -r ~/a ~/tmp/a
printAndEvaluateDestinationDir
# rmDestinationDir
# One
rmDestinationDir
scp -r ~/a ~/tmp/a
printAndEvaluateDestinationDir
# Two
rmDestinationDir
scp -r ~/a ~/tmp/a
scp -r ~/a ~/tmp/a
printAndEvaluateDestinationDir
#--------------------------------------------------
#--------------------------------------------------
# recreateDestinationDir
# One
recreateDestinationDir
scp -r ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
# Two
recreateDestinationDir
scp -r ~/a/ ~/tmp/a
scp -r ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
# rmDestinationDir
# One
rmDestinationDir
scp -r ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
# Two
rmDestinationDir
scp -r ~/a/ ~/tmp/a
scp -r ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
#--------------------------------------------------
#--------------------------------------------------
# recreateDestinationDir
# One
recreateDestinationDir
scp -r ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
# Two
recreateDestinationDir
scp -r ~/a/ ~/tmp/a
scp -r ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
# rmDestinationDir
# One
rmDestinationDir
scp -r ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
# Two
rmDestinationDir
scp -r ~/a/ ~/tmp/a
scp -r ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
#--------------------------------------------------
#--------------------------------------------------
# recreateDestinationDir
# One
recreateDestinationDir
scp -a ~/a/ ~/tmp
printAndEvaluateDestinationDir
# Two
recreateDestinationDir
scp -r ~/a/ ~/tmp/a
scp -r ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
# rmDestinationDir
# One
rmDestinationDir
scp -r ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
# Two
rmDestinationDir
scp -r ~/a/ ~/tmp/a
scp -r ~/a/ ~/tmp/a
printAndEvaluateDestinationDir
#--------------------------------------------------


logecho "Expected to Fail" # todo replace function
#--------------------------------------------------
# recreateDestinationDir
# One
recreateDestinationDir
rsync -a ~/a ~/tmp/dest/a
printAndEvaluateDestinationDir
# Two
recreateDestinationDir
rsync -a ~/a ~/tmp/dest/a
rsync -a ~/a ~/tmp/dest/a
printAndEvaluateDestinationDir
# rmDestinationDir
# One
rmDestinationDir
rsync -a ~/a ~/tmp/dest/a
printAndEvaluateDestinationDir
# Two
rmDestinationDir
rsync -a ~/a ~/tmp/dest/a
rsync -a ~/a ~/tmp/dest/a
printAndEvaluateDestinationDir
#--------------------------------------------------
