path := A_ScriptDir . "\words.txt"
curLine := 1
stopped := false

Gui, +AlwaysOnTop
Gui, Font, s14
Gui, Add, Text, vCurLineText w150 h20, Line: %curLine%
Gui, Add, Text, vWordText w150 h20, Word: 
Gui, Show, x10 y10, Word Display

Loop
{
	IfWinExist, ahk_exe LeagueClientUx.exe ; 롤 핵경고 방지
	{
		Msgbox, ahk has been terminated due to the execution of League of Legends.
		Exitapp
	}
}

GuiClose:
GuiEscape:
    ExitApp

UpdateGui()
{
	global curLine, path
	GuiControl,, CurLineText, Line: %curLine%
	FileReadLine, word, %path%, %curLine%
	if (ErrorLevel = 1) {

		word := "(Error)"
		MsgBox, word
	}
	
	GuiControl,, WordText, Word: %word%
}

F1::
	stopped := false
	Loop
	{
		if (stopped)
			break

		FileReadLine, word, %path%, %curLine%
		if (ErrorLevel = 1) {
			MsgBox, failed
			break
		}
		SendInput, %word%{enter}
		Sleep, 40
		curLine++
		UpdateGui()
	}
	return

F2::
	stopped := true

	curLine -= 2
	if (curLine < 1)
		curLine = 1
	UpdateGui()
	return

F6::
	exitApp