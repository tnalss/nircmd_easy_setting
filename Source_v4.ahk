;폴더생성
FileCreateDir,C:\NirCmd
FileCreateDir,C:\NirCmd\Icon
;nircmd설치
FileInstall,C:\reo\nircmd.exe,C:\NirCmd\nircmd.exe,1
FileInstall,C:\reo\NirCmd.chm,C:\NirCmd\NirCmd.chm,1
FileInstall,C:\reo\nircmdc.exe,C:\NirCmd\nircmdc.exe,1
;아이콘설치
FileInstall,C:\reo\icon\headset.ico,C:\NirCmd\Icon\headset.ico,1
FileInstall,C:\reo\icon\speaker.ico,C:\NirCmd\Icon\speaker.ico,1

Run, mmsys.cpl

Gui, Add, Checkbox , x80 y19 w190 h20 vmute, 마이크 음소거
Gui, Add, Edit, x12 y49 w220 h30 -VScroll vspeaker1 , 스피커 이름
Gui, Add, Edit, x12 y89 w220 h30 -VScroll vmic1, 마이크 이름
Gui, Add, Edit, x272 y49 w220 h30 -VScroll vspeaker2 , 헤드셋 이름
Gui, Add, Edit, x272 y89 w220 h30 -VScroll vmic2, 헤드셋 마이크 이름
Gui, Add, Text, x12 y19 w190 h20 , 스피커

Gui, Add, Text, x272 y19 w190 h20 , 헤드셋
Gui, Add, Button, x392 y129 w100 h30 gmake, 만들기
Gui, Add, Text, x12 y139 w340 h20 , 제작자 - Reo          블로그 - https://reonic.tistory.com/
Gui, Show, x481 y399 h173 w509, SoundChangerMaker v4
Return

make:
gui,submit,nohide
IfExist,C:\NirCmd\*.cmd
	FileDelete,C:\NirCmd\*.cmd

;음소거선택안했을경우 S.cmd , H.cmd 생성
If (mute = 0)
{
FileAppend,nircmd.exe setdefaultsounddevice "%speaker1%" `nnircmd.exe setdefaultsounddevice "%speaker1%" 2 `nnircmd.exe setdefaultsounddevice "%mic1%" `nnircmd.exe setdefaultsounddevice "%mic1%" 2,C:\NirCmd\S.cmd
sleep,100
FileAppend,nircmd.exe setdefaultsounddevice "%speaker2%" `nnircmd.exe setdefaultsounddevice "%speaker2%" 2 `nnircmd.exe setdefaultsounddevice "%mic2%" `nnircmd.exe setdefaultsounddevice "%mic2%" 2,C:\NirCmd\H.cmd
sleep,100

}


;음소거선택한경우
If (mute = 1)
{
FileAppend,nircmd.exe setdefaultsounddevice "%speaker1%" `nnircmd.exe setdefaultsounddevice "%speaker1%" 2 `nnircmd.exe setdefaultsounddevice "%mic1%" `nnircmd.exe setdefaultsounddevice "%mic1%" 2 `nnircmd.exe mutesysvolume 1 default_record,C:\NirCmd\S.cmd
sleep,100
FileAppend,nircmd.exe setdefaultsounddevice "%speaker2%" `nnircmd.exe setdefaultsounddevice "%speaker2%" 2 `nnircmd.exe setdefaultsounddevice "%mic2%" `nnircmd.exe setdefaultsounddevice "%mic2%" 2 `nnircmd.exe mutesysvolume 0 default_record,C:\NirCmd\H.cmd
sleep,100

}

;s와 h 잘안보이게 실행하는 Speaker.cmd와 Headset.cmd 생성
FileAppend,nircmd.exe exec hide "C:\NirCmd\S.cmd",C:\NirCmd\Speaker.cmd
sleep,100
FileAppend,nircmd.exe exec hide "C:\NirCmd\H.cmd",C:\NirCmd\Headset.cmd
sleep,100


;바로가기 생성 s,h 말고 speaker랑 headset으로 생성
FileCreateShortcut,C:\NirCmd\Speaker.cmd,스피커.lnk,C:\NirCmd,,by Reo,C:\NirCmd\Icon\speaker.ico,,,7
sleep,100
FileCreateShortcut,C:\NirCmd\Headset.cmd,헤드셋.lnk,C:\NirCmd,,by Reo,C:\NirCmd\Icon\headset.ico,,,7
sleep,100

msgbox, 완료

return



GuiClose:
ExitApp



F12::
ExitApp
return

F11::
reload
return