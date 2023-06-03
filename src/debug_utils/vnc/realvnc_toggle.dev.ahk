#Requires AutoHotkey v2.0
#SingleInstance

; should create some modules
; so to kinda go through the flow of creating said scripts / macro
; should record clicks and keypresses of specific windows and log it (title class etc)
; perhaps even screenshot. in order to validate the script and the flow. can 
; compare the two screenshots and see if they are the same. / or just "expected screenshot"
; mouse movements are generally not needed. and perhaps have a undo button

SetWorkingDir A_ScriptDir
; add in my fileObj script in here too
; out:= EnvGet("LOCALAPPDATA") "\Programs\AutoHotkey\Compiler\Ahk2Exe.exe"
; C:\Program Files\AutoHotkey
; if not A_IsAdmin
; 	Run *RunAs "%A_ScriptFullPath%" ;
; WinGet, active_id, ID, "A"
active_id := WinGetID("A")
WinActivate(active_id)
MouseGetPos &ogxpos, &ogypos
; FileDelete('log.txt')
; tooltip "hi"
; FileAppend("X11VNC :" StartTime ":" ElapsedTime "`n", "log.txt")
; Return Back to current editor
;----------------------
#include "C:\Users\Jason\Downloads\UIA-v2-main\Lib\UIA.ahk"
; tooltip A_TitleMatchMode ; 2 is default
; sleep 100
; SetTitleMatchMode "RegEx"
; can use goto statements... during dev
if !WinExist("- Properties ahk_exe vncviewer.exe"){
    ; debug skip
    tooltip 'already open'
    sleep 300
    tooltip
    WinActivate("- VNC Viewer ahk_exe vncviewer.exe")
    ;; for debug probably dont need the whole script... that's why it's annoying to dev
    ; Send "{F8}o" ; f8 is toggle, o is for options / properties
    ControlSend("{F8}o",,'A')
    ; Send "o"
    ;; might need my mouse over it.... wonder if it captures
    ; ControlSend("{F8}",'A')
    ; it was toggling
    ; 
    ; vncviewerEl := UIA.ElementFromHandle("- VNC Viewer ahk_exe vncviewer.exe")
    ; WinActivate("- Properties vncviewer.exe")
}else{
    WinActivate("- Properties ahk_exe vncviewer.exe")
}


tooltip 'waiting'

WinWaitActive("- Properties ahk_exe vncviewer.exe")
tooltip
; vncviewerEl := UIA.ElementFromHandle("- Properties vncviewer.exe") ; not title of active window...
; another one of those admin required things
vncviewerEl := UIA.ElementFromHandle("- Properties ahk_exe vncviewer.exe")
; vncviewerEl.ElementFromPath("YYYYYYRY2").Toggle() ; Invoke / Click / toggle works too
toggleReadOnlyEl := vncviewerEl.ElementFromPath("YYYYYYRY2") ; checkmark
toggleReadOnlyEl.Toggle() ; toggle works too. does some funny buisness though
toggleState := toggleReadOnlyEl.ToggleState
; vncviewerEl.ElementFromPath("YY/0").Click() ; toggle works too. does some funny buisness though
vncviewerEl.ElementFromPath("YY/0").Toggle() ; toggle works too. does some funny buisness though
; vncviewerEl.ElementFromPath("YYYYYYRY2").Invoke() ; toggle works too

tooltip "Toggle State is " toggleState ? "View mode" : "Interactive mode" ; 1 : 0


; maybe reset
; maybe clean this up later


;----------------------
WinActivate(active_id)
MouseMove ogxpos, ogypos
; sleep 1000
sleep 3000
Exit(0)
