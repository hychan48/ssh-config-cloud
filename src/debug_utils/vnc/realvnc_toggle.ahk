; ./realvnc_toggle.dev.ahk

/* 
If in RealVnc
Have a toggle for view / control
Common shortcuts for toggle read only are
Ctrl + Alt + Shift + R

Not sure if i like this, but can always change later

the command is F8 -> Propeties Toggle View only
* need uia

Type: 50002 (CheckBox) Name: "View-only" LocalizedType: "check box" ClassName: "Button"

vncviewerEl := UIA.ElementFromHandle("vdiadminq1-01:5900 (vdiadminq1-01) - VNC Viewer ahk_exe vncviewer.exe")
vncviewerEl.ElementFromPath("YYYYYYRY2").Highlight()

Class(nn) vwr::CDesktopWin
ahk_exe vncviewer.exe

Might work with just the coordinates+


Properties menu
vdiadminq1-01:5900 - Properties
ahk_class os::Window::Dialog
ahk_exe vncviewer.exe

needs ADMIN
*/
#Requires AutoHotkey v2.0
#SingleInstance force
if not A_IsAdmin{
	; Run *RunAs "%A_ScriptFullPath%" ;
    tooltip 'Run as admin'
    sleep 300
    ExitApp
}

Persistent 1
; #include "C:\Users\Public\Downloads\UIA-v2-main\Lib\UIA.ahk"
#include "C:\Users\Jason\Downloads\UIA-v2-main\Lib\UIA.ahk"
#HotIf WinActive("ahk_exe vncviewer.exe")
; ctrl + alt + shift + r
; <!^+r::toggleVncViewer()
<!<^<+r::toggleVncViewer() ; this works. i was typing wrong key combo
F1::toggleVncViewer() ; this works...
F3::Reload ; this works...
F4::ExitApp ;
return
toggleVncViewer(){
    Tooltip ""
    if !WinExist("- Properties ahk_exe vncviewer.exe"){
        ; dont need to activate... that was for dev
        ; Properties already open
        ; WinActivate("- VNC Viewer ahk_exe vncviewer.exe")
        ; WinWaitActive(,,5)
        Send "{F8}o" ; f8 is toggle, o is for options / properties
        ; ControlSend("{F8}o",,'A') ; control send doesnt always work it seems
    }else{
        WinActivate("- Properties ahk_exe vncviewer.exe")
    }
    WinWait("- Properties ahk_exe vncviewer.exe",,5)
    WinActivate("- Properties ahk_exe vncviewer.exe")
    WinWaitActive("- Properties ahk_exe vncviewer.exe",,5)
    vncviewerEl := UIA.ElementFromHandle("- Properties ahk_exe vncviewer.exe")
    toggleReadOnlyEl := vncviewerEl.ElementFromPath("YYYYYYRY2") ; toggle checkmark for view only
    toggleReadOnlyEl.Toggle() ; Toggle checkmark
    toggleState := toggleReadOnlyEl.ToggleState ; Get state of checkmark
    vncviewerEl.ElementFromPath("YY/0").Invoke()
   WinActivate("- VNC Viewer ahk_exe vncviewer.exe")
    ; weird ti's reversed now?
    textToggleState := !toggleState ? "View mode" : "Interactive mode" ; 1 : 0
    tooltip "Toggle State is " textToggleState
    ; to be real adament. it should check the tooltip before turning off
    SetTimer(tooltip, -3000) ; i dont like this, but it works for now
    return
}
