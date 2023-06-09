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
function logecho() {
    echo "$@" | tee -a logfile.log
}
rm -f logfile.log

# should maybe tee? i just want to count to verify
# Want to copy ~/a to ~/tmp/a or just use realpath
# https://linux.die.net/man/1/test
# stdbuf  to persist color
function printAndEvaluateDestinationDir(){
    script -efq -c "tree ~/tmp" | tee -a logfile.log
    test -e ~/tmp/a/a1/a2/a3/a4.txt && logecho "OK" ||logecho "ERROR" # good
    test -e ~/tmp/a1/a2/a3/a4.txt && logecho "ERROR" || logecho "OK" # bad
}
# unalias recreateDestinationDir
# unalias rmDestinationDir
alias recreateDestinationDir='rm -rf ~/tmp && mkdir ~/tmp'
alias rmDestinationDir='rm -rf ~/tmp'