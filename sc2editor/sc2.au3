; prep before running this:
; also: rebind rotate model keys to , and . (left, right)
; also: set viewport to "Portrait" in scene editor

; window configuration before launch:
; - messages window closed (ctrl+shift+m)
; - cutscene editor panes shown (f11)

; need to use 32bit, because the editor is a 32bit process..
#AutoIt3Wrapper_UseX64=n

Opt("WinTitleMatchMode", 4) ;1=start, 2=subStr, 3=exact, 4=advanced, -1 to -4=Nocase
Opt("MouseCoordMode", 0)
Opt("PixelCoordMode", 0)

$title_terrain = "[REGEXPTITLE:Terrain.*StarCraft II Editor]"
$title_data = "[REGEXPTITLE:Data.*StarCraft II Editor]"
$title_cseditor = "[REGEXPTITLE:Cutscene Editor.*StarCraft II Editor]"

; Run("e:\sc2\StarCraft\ II\ Editor.exe")
WinActivate($title_terrain)
WinWaitActive($title_terrain)

; activate messages window
Send("^+m")
; then hide it away
WinActivate($title_terrain)
WinWaitActive($title_terrain)

Dim $i
;Dim $units = StringSplit("Zergling,Baneling,Banshee", ",")
;Dim $units = StringSplit("Probe,Zealot,Stalker,Sentry,Observer,Immortal,Colossus,Phoenix,Carrier,Mothership", ",")
Dim $units = StringSplit("Archon,Carrier,Colossus,Dark Templar,High Templar,Immortal,Interceptor,Mothership,Observer,Phoenix,Probe,Sentry,Stalker,Void Ray,Warp Prism (Transport Mode),Zealot", ",")
Dim $unit_count = UBound($units)

For $i = 1 to $unit_count - 1
	; open data
	Send("{F7}")
	WinWaitActive($title_data)

	; open search
	; Send("^f")
	; WinWaitActive("Find")

	; nope.. click the search inside the control instead
	; ControlSetText($title_data, "", "[ID:18]", $units[$i])
	; ControlFocus($title_data, "", "[ID:18]")
	; Send("{ENTER}")

	; Oh god, I don't even have to use the search..
	ControlFocus($title_data, "", "[ID:1023]")
	ControlListView($title_data, "", "[ID:1023]", "SelectClear")
	$idx = ControlListView($title_data, "", "[ID:1023]", "FindItem", $units[$i], 0)
	ControlListView($title_data, "", "[ID:1023]", "Select", $idx)

	; activate the list and press POS1 then Ctrl+P because I can't be arsed
	; to read the docs on how to control the list.
	; ControlFocus($title_data, "", "[ID:1023]")
	; Send("{HOME}")
	Send("^p")

	; wait for cutscene editor to open
	Local $hWnd = WinWaitActive($title_cseditor)

	; send shift+f, zoom to fit
	Send("+f")
	Sleep(50)
	; send ] to rotate 45° to the right
	Send(".")
	Sleep(50)

	; then, crazy stuff.. right click on the animation element
	; and select "reset animation duration", because we can't fucking assign
	; a hotkey to that that works.
	; ControlClick($title_cseditor, "", "[ID:66]", "menu", 1, 100, 1)
	; n/m, shift+f10 does the trick ("menu key") .. holy shit, this is a fickle bitch
	; ControlFocus($title_cseditor, "", "[ID:66]")
	; ControlClick($title_cseditor, "", "[ID:66]", "left", 1, 5, 5)
	; Now ..I don't know ..color matching I guess

	;MsgBox(0, "", PixelGetColor(948, 683))
	;Exit

	;$pos = PixelSearch(200, 200, 1000, 1000, 6724095, 20, 2, $hWnd)
	;MsgBox(0, "", $pos[0] & $pos[1])
	;MouseClick("menu", $pos[0], $pos[1], 1)

	ControlClick($title_cseditor, "", "[ID:66]", "right", 1, 200, 25)
	Sleep(50)
	Send("{DOWN}")
	Sleep(50)
	Send("{DOWN}")
	Sleep(50)
	Send("{ENTER}")
	Sleep(50)

	; send f11 for huge view (hide all panes)
	Send("{F11}")
	Sleep(50)

	; send alt+f11 then enter to record video
	Send("!{F11}")
	WinWaitActive("Record New Video")
	;ControlSend("Record New Video", "", "[ID:20]", "{SPACE}")

	;Exit

	Send("{ENTER}")
	; Sleep(100) ; no idea why, pressing enter immediately won't work
	; ControlClick("Record New Video", "", "[CLASS:Button; INSTANCE:5]")

	; ControlFocus($title, "Search", "[CLASS:SysTabControl32; INSTANCE:3]")
	; sleep 10 seconds.. is there any animation that runs longer?
	Sleep(10000)

	; f11 again to reactivate all panes
	Send("{F11}")
FileCopy("c:\\Users\\mr\\Documents\\StarCraft II\\Videos\\Video.y4m", "f:\\_v\\" & $units[$i] & ".y4m")
Next

; hide messages again once we're done
Send("^+m")

MsgBox(0, "", "done!")