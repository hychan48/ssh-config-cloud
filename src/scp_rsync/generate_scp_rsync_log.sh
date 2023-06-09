#!/bin/zsh
# Initialize Folders
# todo reset folder per run as well... to try more risky stuff.
alias recreateDestinationDir='rm -rf ~/tmp && mkdir ~/tmp'
alias rmDestinationDir='rm -rf ~/tmp'
alias toNull='/dev/null 2>&1'
# alias toNull='> /dev/null 2>&1'
function InitializeDummyFolders(){
    # todo watch if ~/a gets changed maybe
    mkdir -p ~/a/a1/a2/a3
    touch ~/a/a1/a2/a3/a4.txt
    tree ~/a | tee -a logfile.log
}
InitializeDummyFolders
function logecho() {
    echo "$@" | tee -a logfile.log
    # echo -e "\e[32mOK\e[0m" # green ok

}
rm -f logfile.log

# input is the cmd to run multiple times
function printAndEvaluateDestinationDir(){
    # log tree; for debug use 1=test;# fixme, echo two two logs one that represents terminal and one that represents log file
    # tree ~/tmp | tee -a logfile.log | grep "4 directories, 1 file" && logecho "OK: "$1 ||(logecho "ERROR: "$1)
    # tree ~/tmp | tee -a logfile.log | (grep "4 directories, 1 file" > toNull) && logecho "OK: "$1 ||(logecho "ERROR: "$1)
    # tree ~/tmp | tee -a logfile.log | (grep "4 directories, 1 file" > toNull) && logecho "OK: "$1 ||(logecho "ERROR: $1"; tree ~/tmp | tee -a logfile.log)
    tree ~/tmp | (grep "4 directories, 1 file" > toNull) && logecho "OK: "$1 ||(logecho "ERROR: $1"; tree ~/tmp | tee -a logfile.log)
}



# todo maybe also check if '~/a' get changed. and also reset '~/a' (src folder)
# tests 4 scenarios, hardcoded to datastructure from InitializeDummyFolders
# 1,2:destination exists once, twice; 3,4: destination does not exist once, twice
# maybe add N times
function expectedToPass(){
    # if env var 'JC_DEV' is equal to 'debug', then don't clear. otherwise clear
    # this would be a great place for a decorator
    # fixme? return error code if error? / pip to stderr?
    if [ $JC_DEV = "debug" ]; then
        clear
        rm -f logfile.log
    fi


    local copycmd="$1" # 'rsync -r ~/a ~/tmp'
    #--------------------------------------------------
    logecho "#--------------------------------------------------"
    # recreateDestinationDir
    logecho "DExists: ~/tmp: "$copycmd
    # One
    recreateDestinationDir
    eval $copycmd # rsync -a ~/a ~/tmp
    printAndEvaluateDestinationDir $copycmd
    # Two
    recreateDestinationDir
    eval $copycmd # rsync -a ~/a ~/tmp
    eval $copycmd # rsync -a ~/a ~/tmp
    printAndEvaluateDestinationDir $copycmd
    if [ $JC_DEV = "debug" ]; then
        tree ~/tmp | tee -a logfile.log # should alias this
    fi
    #--------------------------------------------------
    # rmDestinationDir
    logecho "DNE   : ~/tmp : "$copycmd
    # One
    rmDestinationDir
    eval $copycmd # rsync -a ~/a ~/tmp
    printAndEvaluateDestinationDir $copycmd
    # Two
    rmDestinationDir
    eval $copycmd # rsync -a ~/a ~/tmp
    eval $copycmd # rsync -a ~/a ~/tmp
    printAndEvaluateDestinationDir $copycmd
    if [ $JC_DEV = "debug" ]; then
        tree ~/tmp | tee -a logfile.log # should alias this
    fi
    logecho "#--------------------------------------------------"
    #--------------------------------------------------

}
function windowsExpectedToPass(){
    # todo
    : '
    #!powershell
    # Get-Tree.ps1
    # in repo

    '
    if [ $JC_DEV = "debug" ]; then
        clear
        rm -f logfile.log
    fi
    # todo / fixme
    local copycmd="$1" # 'rsync -r ~/a win11:~/tmp' 
    eval $copycmd
    


    
}
# dev function
function __expectedToPass(){
    # Comment block in bash is :. : does nothing, but it's a command, so it's valid syntax.
    # source is interesting maybe because ic all them functions? or typo. oop[s]
    # fixme might be better to use an env variable to pass in the command to toggle like
    # JC_DEV='debug'
    : '
    exec -l zsh
    JC_DEV='debug'
    unset JC_DEV
    source generate_scp_rsync_log.sh
    cat ~/.ssh/config
    '
}
function sshConfigNotes(){
    :'
    code ~/.ssh/config
    '
    :'
    Host localhost remotehost
        Hostname 127.0.0.1
        User root
        IdentityFile ~/.ssh/id_ed25519
        StrictHostKeyChecking no
    '
}
function devHighlights(){
    #fixme check where it's called from
    : '
    export JC_DEV='debug'
    JC_DEV='debug'
    # export persists even withe exec -l zsh..
    source generate_scp_rsync_log.sh
    exec -l zsh
    unset JC_DEV
    printenv JC_DEV
    echo JC_DEV
    '

    # Copy from Remote('remotehost:') to Targethost('localhost:')
    # Note: for testing both remote and target are localhost
    expectedToPass '(mkdir -p ~/tmp;cd ~/tmp;cp -r ~/a .)' # 4/4, baseline cp command
    
    # ssh copy. if folder exists uses these. NOTE the non-trailing slash ~/a
    expectedToPass 'rsync -a ~/a localhost:~/tmp' # 4/4, rsync can create only create one folder. i.e. ~/tmp, but not ~/tmp/x
    expectedToPass 'scp -r ~/a localhost:~/tmp' # 2/4, only works if destination (~/tmp) already exists
    
    # IF copy from LOCAL to REMOTE SCP WORKS. i.e. reversed. not recommended because of security for our use case
    expectedToPass '(mkdir -p ~/tmp;cd ~/tmp;scp -r remotehost:~/a .)' # 4/4
    
    # By adding the trailing-slash ~/a/ pseudo 'renames' folder to ~/tmp

    # Nested folder. Only Creates One Folder max. same with scp
    expectedToPass 'rsync -a ~/a localhost:~/tmp' # 4/4
    expectedToPass 'rsync -a ~/a localhost:~/tmp/x' # 2/4. note error catching is misleading, prints tree though
    expectedToPass 'rsync -a ~/a localhost:~/tmp/x/y' # 0/4

    # expectedToPass 'rsync -a ~/a localhost:~/tmp/..' # 2/4. note error catching is misleading, prints tree though

    # Windows try -... right cant tree over there
    # expectedToPass 'rsync -a ~/a win11:~/tmp' # 0/4
    # expectedToPass 'scp -r ~/a win11:~/tmp' # 0/4
    : '
    JC_DEV='debug' ; source generate_scp_rsync_log.sh
    ssh win11 "hostname"
    '
    windowsExpectedToPass 'rsync -r ~/a win11:~/tmp' # 0/4
    windowsExpectedToPass 'scp -r ~/a win11:~/tmp' # 0/4
    windowsExpectedToPass 'scp -r ~/a/ win11:~/tmp' # 0/4
    scp -r ~/a win11:~/tmp
    
    # windows stuff.. surpsingly works
    # assumign default shell is powershell 5.1 and not cmd 
    ssh win11 "Remove-Item -Path ~/tmp -Recurse"
    ssh win11 'mkdir ~/tmp'
    ssh win11 "Get-Tree ~/tmp"
    # quote the string!
    scp -r ~/a win11:'$HOME/tmp'
    # scp -r ~/a win11:'~/tmp' # no worky. although it does work if you create in powershell
    # scp -r ~/a win11:$HOME/tmp # wont work if no quotes. SINGLE quotes
    
    scp -r ~/a ssh://win11:~/tmp
    scp -r ~/a ssh://win11:~/tmp

}
# if not debug, then run the tests
if [ '$JC_DEV' != "debug" ]; then
    # devHighlights
    
fi


function runFullSuite(){
    # Cp Same behavior
    # only works if destination exists
    # 2/4 means first 2 passed. i.e. 1,2,!3,!4
    # even 2/4 is fine. just make sure the destination folder exists already
    expectedToPass '(mkdir -p ~/tmp;cd ~/tmp;cp -r ~/a .)' # 4/4
    expectedToPass '(cd ~/tmp;cp -r ~/a .)' # 2/4
    expectedToPass 'cp -r ~/a ~/tmp' # 2/4
    expectedToPass 'cp -r ~/a/ ~/tmp' # 2/4
    expectedToPass 'cp -r ~/a ~/tmp/a' # 1/4
    expectedToPass 'cp -r ~/a/ ~/tmp/a' # 1/4
    expectedToPass 'cp -r ~/a ~/tmp/a/' # 1/4
    expectedToPass 'cp -r ~/a/ ~/tmp/a/' # 1/4



    ## rsync -r and -a does same thing for us purposes. 
    ## --archive is -a. -r is --recursive. archive is recursive and preserves metadata
    expectedToPass 'rsync -a ~/a ~/tmp' # 4/4
    expectedToPass 'rsync -r ~/a ~/tmp' # 4/4
    expectedToPass 'rsync -a ~/a/ ~/tmp' # 0/4
    expectedToPass 'rsync -r ~/a/ ~/tmp' # 0/4
    expectedToPass 'rsync -r ~/a ~/tmp/a' # 0/4

    ## SCP
    ### only works if destination exists
    expectedToPass '(mkdir -p ~/tmp;cd ~/tmp;scp -r ~/a .)' # 4/4
    expectedToPass '(cd ~/tmp;scp -r ~/a .)' # 2/4
    expectedToPass 'scp -r ~/a ~/tmp/.' # 2/4
    expectedToPass 'scp -r ~/a ~/tmp' # 2/4
    expectedToPass 'scp -r ~/a/ ~/tmp' # 2/4
    expectedToPass 'scp -r ~/a/ ~/tmp' # 2/4
    expectedToPass 'scp -r ~/a ~/tmp/a' # 1/4

    # With SSH expect same behavior
    ## SSH Config localhost -> root@localhost
    ## Rsync
    expectedToPass 'rsync -a ~/a localhost:~/tmp' # 4/4
    expectedToPass 'rsync -r ~/a localhost:~/tmp' # 4/4
    expectedToPass 'rsync -a ~/a/ localhost:~/tmp' # 0/4
    expectedToPass 'rsync -r ~/a/ localhost:~/tmp' # 0/4
    expectedToPass 'rsync -r ~/a localhost:~/tmp/a' # 0/4

    ## SCP
    ### only works if destination exists
    # basically cant run this without sshing first:. might as well just copy twice or something
    # _expectedToPass '(mkdir -p ~/tmp;cd ~/tmp;scp -r ~/a .)' # 4/4
    # _expectedToPass '(cd ~/tmp;scp -r ~/a .)' # 2/4 
    # _expectedToPass 'scp -r ~/a .' # 4/4
    # this cmd is misleading because src and dst are same. so the cd would work
    # _expectedToPass '(cd ~/tmp;scp -r ~/a localhost:.)' # 0/4 
    expectedToPass 'scp -r ~/a localhost:~/tmp' # 2/4
    expectedToPass 'scp -r ~/a localhost:~/tmp/' # 2/4
    expectedToPass 'scp -r ~/a/ localhost:~/tmp' # 2/4
    expectedToPass 'scp -r ~/a/ localhost:~/tmp' # 2/4
    expectedToPass 'scp -r ~/a localhost:~/tmp/a' # 1/4
    
    
    # Probably fails:
    # logecho "Expected to Fail" # todo replace function
    # expectedToPass 'rsync -a ~/a ~/tmp/dest/a' # no comment fails...
}
# runFullSuite

# dev stuff
# echo hi
# expectedToPass 'rsync -a ~/a ~/tmp' # adding ~... w
# expectedToPass 'rsync -a ~/a ~/tmp'
# tree ~/tmp
# tree ~/a

# echo "green red" | grep --color=always -E "green|red" | sed -E 's/green/OK/g; s/red/Error/g' #
# echo "green red" | grep --color=always -E "green|$" | GREP_COLORS='mt=32;01' grep --color=always -E "red|$"
# echo "green red" | grep --color=always -E "green|$" | GREP_COLORS='mt=31;01' grep --color=always -E "red|$"
# echo "green red" | GREP_COLORS='mt=31;01' grep --color=always -E "green|$" | GREP_COLORS='mt=32;01' grep --color=always -E "red|$"
# echo "green red" | GREP_COLORS='mt=31;01' grep --color=always -E "green|$" | GREP_COLORS='mt=32;01' grep --color=always -E "red|$"

# # this one damn that's neat. but tee makes it useless
# echo "green red" | GREP_COLORS='mt=32;01' grep --color=always -E "green|$" | GREP_COLORS='mt=31;01' grep --color=always -E "red|$" | tee -a color.log
