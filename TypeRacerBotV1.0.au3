#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <string.au3>
#include <IE.au3>
#include <Misc.au3>

$Word = Null

$Form1 = GUICreate("Form1", 232, 104, 192, 132)
$Button = GUICtrlCreateButton("Start IE", 136, 64, 75, 25)
$txt = GUICtrlCreateLabel("Word doesnt exist   |", 14, 72, 100, 15)
$Input = GUICtrlCreateInput("F1", 64, 8, 33, 21)
$HkK = GUICtrlCreateLabel("Hotkey:", 16, 12, 40, 17)
GUISetState(@SW_SHOW)


_core()

Func _core()
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				Exit
			Case $Button
				Global $TR = _IECreate("http://play.typeracer.com/")
				$HK = GUICtrlRead($Input)
				HotKeySet("{" & $HK & "}", '_main')
		EndSwitch
	WEnd
EndFunc   ;==>_core

Func _main()
	$TR_STR = _IEBodyReadHTML($TR)
	$Word = _StringBetween($TR_STR, '<span id="hwFirstgwt-uid-9" style="color: rgb(153, 204, 0);">', '</span>')
	Send("{F1 UP}")
	If $Word = "" Then
		Sleep(50)
	Else
		$Word = $Word[0]
		Send($Word)
		GUICtrlSetData($txt, $Word)
	EndIf
	If $Word = "" Then
		GUICtrlSetData($txt, "Word doesnt exist   |")
	EndIf
	_core()
EndFunc   ;==>_main

