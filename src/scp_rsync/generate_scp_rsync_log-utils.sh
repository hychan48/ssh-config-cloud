#!/bin/zsh
# more like misc notes now
# todo / source this file functions

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

tree ~/tmp
test -e ~/tmp/a/a1/a2/a3/a4.txt && echo "exists" || echo "does not exist" # good
test -e ~/tmp/a1/a2/a3/a4.txt && echo "exists" || echo "does not exist" # bad

cat logfile.log
less logfile.log

# Archive
# alias logecho='tee -a logfile.txt'
# unalias logecho


# less logfile.log
# script -efq -c "ls --color=auto" >(cat) | tee outpu.log
# but i get stuck for some reaosn
# useful info
# rm -f output.log ; script -efq -c "ls --color=auto" | tee output.log;cat output.log