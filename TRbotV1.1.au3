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

$Form1 = GUICreate("TRbot", 232, 104, 192, 132)
$Button = GUICtrlCreateButton("Start IE", 136, 64, 75, 25)
$txt = GUICtrlCreateLabel("Word doesnt exist   |", 14, 72, 100, 15)
$Input = GUICtrlCreateInput("F2", 90, 8, 33, 21)
$HkK = GUICtrlCreateLabel("Hotkey:", 20, 12, 40, 17)
$InPer = GUICtrlCreateInput("1", 90, 35, 33, 21)
$LabPer = GUICtrlCreateLabel("Per/words:", 20, 39, 59, 17)
GUISetState(@SW_SHOW)


_core()

Func _core()
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				Exit
			Case $Button
				If Not ProcessExists('iexplore.exe') Then
					Global $TR = _IECreate("http://play.typeracer.com/")
					$HK = GUICtrlRead($Input)
					HotKeySet("{" & $HK & "}", '_main')
					Global $Per = GUICtrlRead($InPer)
				Else
					$mbYN = MsgBox(4, 'Error', 'IE.exe already exist' & @CRLF & 'Do you wanna kill IE.exe process?')
					If $mbYN = $IDYES Then
						ProcessClose('iexplore.exe')
					EndIf

				EndIf
		EndSwitch
	WEnd
EndFunc   ;==>_core

Func _main()
	Local $i = 0
	Do
		$TR_STR = _IEBodyReadHTML($TR)
		$Word = _StringBetween($TR_STR, '<span id="hwFirstgwt-uid-9" style="color: rgb(153, 204, 0);">', '</span>')
		Send("{F1 UP}")
		If $Word = "" Then
			GUICtrlSetData($txt, "Word doesnt exist   |")
			_core()
		Else
			$Word = $Word[0]
			Send($Word)
			GUICtrlSetData($txt, $Word)
			$i += 1
		EndIf
	Until $i = $Per
EndFunc   ;==>_main

