#SingleInstance, Force
Sendmode Input
MsgBox, 0, Auto chip gen - RockandTroll, Please make sure the chip you want to build is in slot 1, this script will NOT unbind any Orange chips.
SetFormat, Float, 0
SetWorkingDir, %A_ScriptDir%


; get window position and store it into variables ;

funcFindGo2()
; Searches for the SuperGo2 Window and Activates it if it is inactive.
{
    if not WinExist("GalaxyOrbit4")
    MsgBox, Window doesnt exist.
Else
    WinActivate
}

funcGetWinPOS()
; Get the position and size of the SuperGo2 window and store it in variables.
{
    global WinX
    global WinY
    global WinWidth
    global WinHeight
    WinGetPos, WinX, WinY, WinWidth, WinHeight
}

; define generation functions

funcLookForEmpty(WinX, WinY, WinWidth, WinHeight)
; looks for empty slots in the gen window
{
    global EmptyFound
    ImageSearch, EmptyX, EmptyY, %WinX%, %WinY%, %WinWidth%, %WinHeight%, *10 images\emptyslot3.png
        If(ErrorLevel = 2) Or (ErrorLevel = 1) {
            ImageSearch, EmptyX, EmptyY, %WinX%, %WinY%, %WinWidth%, %WinHeight%, *10 images\emptyslot2.png
                If(ErrorLevel = 2) Or (ErrorLevel = 1)
                    EmptyFound = false
                else {
                    EmptyFound = true
                }
        }
        else {
            EmptyFound = true
        }
       

}

funcLocateAuto(WinX, WinY, WinWidth, WinHeight)
; locate and store position of auto gen button
{
    global AutoX
    global AutoY
    ImageSearch, AutoX, AutoY, %WinX%, %WinY%, %WinWidth%, %WinHeight%, *10 images\autogen.png
        If(ErrorLevel = 2) Or (ErrorLevel = 1)
            ImageSearch, AutoX, AutoY, %WinX%, %WinY%, %WinWidth%, %WinHeight%, *10 images\autogen2.png
                If(ErrorLevel = 2) Or (ErrorLevel = 1)
                    ImageSearch, AutoX, AutoY, %WinX%, %WinY%, %WinWidth%, %WinHeight%, *10 images\autogen3.png
}


funcClickfirstSlot(WinX, WinY, WinWidth, WinHeight)
; clicks on the chip in the first slot
{
    Sleep 100
    ImageSearch, BindX, BindY, %WinX%, %WinY%, %WinWidth%, %WinHeight%, *10 images\bag.png
    EnvSub, BindX, 526
    EnvSub, BindY, 404
    Click, %BindX%, %BindY%
}

funcMergeAll(WinX,WinY,WinWidth,WinHeight)
; clicks merge all button
{
    global BagX
    global BagY
    Sleep 100
    ImageSearch, MergeX, MergeY, %WinX%, %WinY%, %WinWidth%, %WinHeight%, *10 images\bag.png
    BagX = %MergeX%
    BagY = %MergeY%
    EnvSub, MergeX, 260
    EnvSub, MergeY, 454
    Click, %MergeX%, %MergeY%
}

funcMergeOk(WinX,WinY,WinWidth,WinHeight)
; clicks merge all button
{
    ImageSearch, MergeOKX, MergeOKY, %WinX%, %WinY%, %WinWidth%, %WinHeight%, *10 images\mergeok.png
    Click, %MergeOKX%,%MergeOKY%
}


; run

funcFindGo2()
funcGetWinPos()
funcLocateAuto(WinX, WinY, WinWidth, WinHeight)
lvl5clickX := AutoX - 100
lvl5clickY := AutoY
loop_count = 1
funcLookForEmpty(WinX, WinY, WinWidth, WinHeight)
 Loop, 10000
 {
While(%EmptyFound% = true)
{
    loop_count := loop_count + 1
    funcLookForEmpty(WinX, WinY, WinWidth, WinHeight)
    Click, %AutoX%, %AutoY%
    If(loop_count = 10){
        Click, %lvl5clickX%, %lvl5clickY%
        loop_count = 0
    }

}
sleep 1000
funcClickfirstSlot(WinX, WinY, WinWidth, WinHeight)
sleep 250
funcMergeAll(WinX,WinY,WinWidth,WinHeight)
sleep 1000
funcMergeOk(WinX,WinY,WinWidth,WinHeight)
sleep 2000
funcLookForEmpty(WinX, WinY, WinWidth, WinHeight)
}


esc::ExitApp