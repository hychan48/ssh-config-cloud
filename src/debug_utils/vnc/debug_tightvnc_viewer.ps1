#!pwsh
<#
Having issues with fullscreen
#>

# cd "C:\Program Files\TightVNC"
# cd C:\Program Files\TightVNC\tvnviewer
# vdiadminq1-01:5900
# .\tvnviewer.exe -host=vdiadminq1-01 # works
# .\tvnviewer.exe -host='vdiadminq1-01' -fullscreen='True'
# goddamn registry
# regjump HKEY_CURRENT_USER\SOFTWARE\TightVNC
# .\tvnviewer.exe -fullscreen='True' -host='vdiadminq1-01'
# .\tvnviewer.exe -host='vdiadminq1-01' -fullscreen='True'
# pskill tvnviewer
# .\tvnviewer.exe -h
# .\tvnviewer.exe -host='vdiadminq1-01' -fullscreen='True'
# .\tvnviewer.exe -host='vdiadminq1-01' -fullscreen 'True'
# & .\tvnviewer.exe -host='vdiadminq1-01' -viewonly
# cmd is different...
# it's fucking yes / no, which isnt in the docs
# -warnfullscr	Show full-screen warning.
.\tvnviewer.exe -host=vdiadminq1-01 -fullscreen=yes -warnfullscr=no
# think need full path if done like this...
# &"tvnviewer.exe -host='vdiadminq1-01' -viewonly"
Start-Sleep -Seconds 3
pskill tvnviewer