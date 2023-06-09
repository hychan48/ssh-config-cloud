#!/bin/zsh
# Initialize Folders
# todo reset folder per run as well... to try more risky stuff.
function InitializeDummyFolders(){
    mkdir -p ~/a/a1/a2/a3
    touch ~/a/a1/a2/a3/a4.txt
    tree ~/a
}
InitializeDummyFolders
function logecho() {
    echo "$@" | tee -a logfile.log
    # echo -e "\e[32mOK\e[0m" # green ok

}
rm -f logfile.log

# input is the cmd to run multiple times
function printAndEvaluateDestinationDir(){
    # log tree (maybe can hide)
    tree ~/tmp | tee -a logfile.log | grep "4 directories, 1 file" && logecho "OK: "$1 ||(logecho "ERROR: "$1)
    # fixme... maybe only print tree if error or dont print at all
}
alias recreateDestinationDir='rm -rf ~/tmp && mkdir ~/tmp'
alias rmDestinationDir='rm -rf ~/tmp'


function expectedToPass(){
    local copycmd="$1" # 'rsync -r ~/a ~/tmp'
    #--------------------------------------------------
    logecho "#--------------------------------------------------"
    logecho "copycmd: "$copycmd
    # recreateDestinationDir
    # One
    recreateDestinationDir
    eval $copycmd # rsync -a ~/a ~/tmp
    printAndEvaluateDestinationDir $copycmd
    # Two
    recreateDestinationDir
    eval $copycmd # rsync -a ~/a ~/tmp
    eval $copycmd # rsync -a ~/a ~/tmp
    printAndEvaluateDestinationDir $copycmd
    # rmDestinationDir
    # One
    rmDestinationDir
    eval $copycmd # rsync -a ~/a ~/tmp
    printAndEvaluateDestinationDir $copycmd
    # Two
    rmDestinationDir
    eval $copycmd # rsync -a ~/a ~/tmp
    eval $copycmd # rsync -a ~/a ~/tmp
    printAndEvaluateDestinationDir $copycmd
    logecho "#--------------------------------------------------"
    #--------------------------------------------------

}
# Rsync
expectedToPass 'rsync -a ~/a ~/tmp'
expectedToPass 'rsync -a ~/a ~/tmp/a'
expectedToPass 'rsync -a ~/a/ ~/tmp/a'
expectedToPass 'rsync -a ~/a/ ~/tmp/a'
# SCP
expectedToPass 'scp -a ~/a/ ~/tmp'
expectedToPass 'scp -r ~/a ~/tmp'
expectedToPass 'scp -r ~/a ~/tmp/a'
expectedToPass 'scp -r ~/a/ ~/tmp/a'
expectedToPass 'scp -r ~/a/ ~/tmp/a'
expectedToPass 'scp -r ~/a/ ~/tmp/a'
expectedToPass 'scp -r ~/a/ ~/tmp'
# Probably fails:

logecho "Expected to Fail" # todo replace function
expectedToPass 'rsync -a ~/a ~/tmp/dest/a' # no comment fails...


expectedToPass 'rsync -a ~/a ~/tmp' # adding ~... w
expectedToPass 'rsync -a ~/a ~/tmp'
tree ~/tmp
tree ~/a

echo "green red" | grep --color=always -E "green|red" | sed -E 's/green/OK/g; s/red/Error/g' #
echo "green red" | grep --color=always -E "green|$" | GREP_COLORS='mt=32;01' grep --color=always -E "red|$"
echo "green red" | grep --color=always -E "green|$" | GREP_COLORS='mt=31;01' grep --color=always -E "red|$"
echo "green red" | GREP_COLORS='mt=31;01' grep --color=always -E "green|$" | GREP_COLORS='mt=32;01' grep --color=always -E "red|$"
echo "green red" | GREP_COLORS='mt=31;01' grep --color=always -E "green|$" | GREP_COLORS='mt=32;01' grep --color=always -E "red|$"

# this one damn that's neat. but tee makes it useless
echo "green red" | GREP_COLORS='mt=32;01' grep --color=always -E "green|$" | GREP_COLORS='mt=31;01' grep --color=always -E "red|$" | tee -a color.log
