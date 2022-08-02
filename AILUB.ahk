#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Start:
MsgBox Made by Umut Cevdet Koçak (Discord: Umut#3333)
Gui, Add, Text,, Lütfen yapacağınız işlemi aşağıdan seçiniz.
Gui, Add, Button, default, Çalıştır
Gui, Add, Button, default, Güncelle
Gui, Add, Button, default, Kur
Gui, Add, Button, default, Ayarlar
Gui, Add, Button, default, İptal
Gui, Show, , AILUB
return
GuiClose:
Gui, Cancel
MsgBox, İşlemi iptal ettiniz.
ExitApp
Buttonİptal:
Gui, Cancel
MsgBox, İşlemi iptal ettiniz.
ExitApp
ButtonÇalıştır:
Gui, Cancel
if FileExist("Resources\Installed.ini") {
    IniRead, def, Resources\ip.ini, 1
    IniRead, Link, Resources\Link.ini, 1
    IniRead, Name, Resources\Name.ini, 1
    InputBox, ip, Sunucu adresini giriniz, Sunucu adresini(ipsini) giriniz. (Örnek: play.lightspeeds.tk); Boş bırakırsanız ana menüye atar., , , 140, , , , , %def%
        if (ErrorLevel = 0) {
            if (ip = "") {
                run, cmd.exe /c "%A_ScriptDir%\UltimMC\UltimMC" --launch %Link% --profile %Name%, , Hide
                FileDelete, Resources\ip.ini
                }
            else {
                run, cmd.exe /c "%A_ScriptDir%\UltimMC\UltimMC" --launch %Link% --profile %Name% --server %ip%, , Hide
                FileDelete, Resources\ip.ini
                IniWrite, %ip%, Resources\ip.ini, 1
                }
        }
        else{
                MsgBox, İşlemi iptal ettiniz
            }
}
else {
    MsgBox, Lütfen öncelikle kurunuz.
}
ExitApp
ButtonGüncelle:
Gui, Cancel
if FileExist("Resources\Installed.ini") {
IniRead, Link, Resources\Link.ini, 1
FileMoveDir, UltimMC\instances\%Link%\.minecraft, files, 2
FileRemoveDir, files\mods, 1
FileRemoveDir, files\config, 1
FileRemoveDir, files\defaultconfigs, 1
FileRemoveDir, files\packmenu, 1
FileRemoveDir, files\.slpassword, 1
FileRemoveDir, UltimMC\instances, 1
run, cmd.exe /c title SETUP && UltimMC\UltimMC --import https://www.bit.ly/%Link%, , Min
instance:
if WinExist("New Instance - UltimMC 5"){
Sleep, 2000
Send, {Enter}
downloading:
Sleep, 1000
if WinExist("Please wait... - UltimMC 5"){
Goto, downloading
}
if WinExist("SETUP")
	WinClose
FileDelete, Resources\Link.ini
IniWrite, %Update%, Resources\Link.ini, 1
FileCopyDir, files, UltimMC\instances\%Update%\.minecraft, 1
FileCopy, .sl_password, UltimMC\instances\%Update%\.minecraft\.slpassword, 1
FileRemoveDir, files, 1

MsgBox Güncelleme tamamlandı
}
else {
	Goto, instance
}
}
else {
    MsgBox, Lütfen öncelikle kurunuz.
}
ExitApp
ButtonKur:
Gui, Cancel
RegRead, Hostnm, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters, Hostname
InputBox, Link, Kodu giriniz, Size discorddan verilen kodu giriniz (Örnek: 56FdaX7), , , 130
if (ErrorLevel = 0) {
	InputBox, RAM, RAM Miktarını giriniz, Kaç MB (megabyte) RAM vermek istediğinizi yazınız (Önerilen 3000)., , , 150, , , , , 3000
	if (ErrorLevel = 0) {
		InputBox, Name, İsminizi giriniz, Oyun içinde kullanacağınız ismi giriniz (Örnek: ArdaGaming), , , 130
		if (ErrorLevel = 0) {
			InputBox, Pass, Serverda kullanacağınız şifreyi giriniz., Sunucu şifrenizi giriniz., HIDE, , 130,
			if (ErrorLevel = 0) {
				MsgBox, Lütfen kurulum süresince hiçbir şeye tıklamayınız.
				if WinExist("SETUP")
					WinClose
					account = 
					(
{
    "accounts": [
        {
            "active": true,
            "type": "dummy",
            "ygg": {
                "extra": {
                    "clientToken": "e2311a087cc841cfa6024f7f6966594e",
                    "userName": "%Name%"
                },
                "iat": 1655279002,
                "token": "%Name%"
            }
        }
    ],
    "formatVersion": 3
}
					)
					config = 
					(
					Analytics=true
					AnalyticsClientID=d7d2fade-826e-4661-b5bb-0ea45643db5a
					AnalyticsSeen=2
					AutoCloseConsole=false
					AutoUpdate=false
					CentralModsDir=mods
					ConsoleFont=Courier
					ConsoleFontSize=10
					ConsoleMaxLines=100000
					ConsoleOverflowStop=true
					IconTheme=multimc
					IconsDir=icons
					InstSortMode=Name
					InstanceDir=instances
					JProfilerPath=
					JVisualVMPath=
					JavaPath=javaw
					JsonEditor=
					JvmArgs=
					Language=en_US
					LastHostname=%Hostnm%
					LastUsedGroupForNewInstance=
					LaunchMaximized=false
					MCEditPath=
					MainWindowGeometry=AdnQywACAAAAAAIoAAAAuQAABVcAAAM3AAACMAAAANgAAAVPAAADLwAAAAAAAAAAB4A=
					MainWindowState=AAAA/wAAAAD9AAAAAAAAAqsAAAIIAAAABAAAAAQAAAAIAAAACPwAAAADAAAAAQAAAAEAAAAeAGkAbgBzAHQAYQBuAGMAZQBUAG8AbwBsAEIAYQByAwAAAAD/////AAAAAAAAAAAAAAACAAAAAQAAABYAbQBhAGkAbgBUAG8AbwBsAEIAYQByAQAAAAD/////AAAAAAAAAAAAAAADAAAAAQAAABYAbgBlAHcAcwBUAG8AbwBsAEIAYQByAQAAAAD/////AAAAAAAAAAA=
					MaxMemAlloc=%RAM%
					MinMemAlloc=%RAM%
					MinecraftWinHeight=480
					MinecraftWinWidth=854
					NewInstanceGeometry=AdnQywACAAAAAAJLAAABGgAABTQAAALWAAACUwAAATkAAAUsAAACzgAAAAAAAAAAB4A=
					PagedGeometry=AdnQywACAAAAAAKzAAAAgAAABMwAAANxAAACuwAAAJ8AAATEAAADaQAAAAAAAAAAB4A=
					PasteEEAPIKey=multimc
					PostExitCommand=
					PreLaunchCommand=
					ProxyAddr=127.0.0.1
					ProxyPass=
					ProxyPort=8080
					ProxyType=None
					ProxyUser=
					RecordGameTime=true
					SelectedInstance=
					ShowConsole=false
					ShowConsoleOnError=true
					ShowGameTime=true
					ShowGlobalGameTime=true
					ShownNotifications=
					UpdateChannel=custom
					UseNativeGLFW=false
					UseNativeOpenAL=false
					WrapperCommand=
					)
				FileDelete, UltimMC\ultimmc.cfg
				FileDelete, UltimMC\accounts.json
				FileRemoveDir, UltimMC\instances, 1
				FileRemoveDir, UltimMC\cache, 1
				FileAppend, %account%, UltimMC\accounts.json
				FileAppend, %config%, UltimMC\ultimmc.cfg
				run, cmd.exe /c title SETUP && UltimMC\UltimMC --import https://www.bit.ly/%Link%, , Min
				lang:
				if WinExist("New Instance - UltimMC 5") {
					Sleep, 100
					Send, {Enter}
					checkdown:
					if WinExist("Please wait... - UltimMC 5"){
					downloading1:
					if WinExist("Please wait... - UltimMC 5"){
						Goto, downloading1
						}
					Sleep, 100
					if WinExist("SETUP")
						WinClose
					FileDelete, Resources\Name.ini
					FileDelete, Resources\Link.ini
					FileDelete, Resources\RAM.ini
					FileDelete, Resources\.sl_password
					FileDelete, UltimMC\instances\%Link%\.minecraft\.sl_password
                    FileCreateDir, Resources
					IniWrite, %RAM%, Resources\RAM.ini, 1
					IniWrite, %Name%, Resources\Name.ini, 1
					IniWrite, %Link%, Resources\Link.ini, 1
					IniWrite, true, Resources\Installed.ini, 1
					FileAppend, %pass%, Resources\.sl_password
					FileCopy, .sl_password, UltimMC\instances\%Link%\.minecraft\
					MsgBox Başarıyla kuruldu.
					}
				else{
					Goto, checkdown
				}
				}
				else {
					Goto, lang

					}
				}
			else {
			MsgBox, İşlemi iptal ettiniz. 
			}
			}
		else {
		MsgBox, İşlemi iptal ettiniz.
		}
		}
	else {
	MsgBox, İşlemi iptal ettiniz.
	}
	}
else {
MsgBox, İşlemi iptal ettiniz.
}
ExitApp
ButtonAyarlar:
Gui, Cancel
if FileExist("Resources\Installed.ini") {
RegRead, Hostnm, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters, Hostname
IniRead, RAM, Resources\RAM.ini, 1
					config = 
					(
					Analytics=true
					AnalyticsClientID=d7d2fade-826e-4661-b5bb-0ea45643db5a
					AnalyticsSeen=2
					AutoCloseConsole=false
					AutoUpdate=false
					CentralModsDir=mods
					ConsoleFont=Courier
					ConsoleFontSize=10
					ConsoleMaxLines=100000
					ConsoleOverflowStop=true
					IconTheme=multimc
					IconsDir=icons
					InstSortMode=Name
					InstanceDir=instances
					JProfilerPath=
					JVisualVMPath=
					JavaPath=
					JsonEditor=
					JvmArgs=
					Language=en_US
					LastHostname=%Hostnm%
					LastUsedGroupForNewInstance=
					LaunchMaximized=false
					MCEditPath=
					MainWindowGeometry=AdnQywACAAAAAAIoAAAAuQAABVcAAAM3AAACMAAAANgAAAVPAAADLwAAAAAAAAAAB4A=
					MainWindowState=AAAA/wAAAAD9AAAAAAAAAqsAAAIIAAAABAAAAAQAAAAIAAAACPwAAAADAAAAAQAAAAEAAAAeAGkAbgBzAHQAYQBuAGMAZQBUAG8AbwBsAEIAYQByAwAAAAD/////AAAAAAAAAAAAAAACAAAAAQAAABYAbQBhAGkAbgBUAG8AbwBsAEIAYQByAQAAAAD/////AAAAAAAAAAAAAAADAAAAAQAAABYAbgBlAHcAcwBUAG8AbwBsAEIAYQByAQAAAAD/////AAAAAAAAAAA=
					MaxMemAlloc=%RAM%
					MinMemAlloc=%RAM%
					MinecraftWinHeight=480
					MinecraftWinWidth=854
					NewInstanceGeometry=AdnQywACAAAAAAJLAAABGgAABTQAAALWAAACUwAAATkAAAUsAAACzgAAAAAAAAAAB4A=
					PagedGeometry=AdnQywACAAAAAAKzAAAAgAAABMwAAANxAAACuwAAAJ8AAATEAAADaQAAAAAAAAAAB4A=
					PasteEEAPIKey=multimc
					PostExitCommand=
					PreLaunchCommand=
					ProxyAddr=127.0.0.1
					ProxyPass=
					ProxyPort=8080
					ProxyType=None
					ProxyUser=
					RecordGameTime=true
					SelectedInstance=
					ShowConsole=false
					ShowConsoleOnError=true
					ShowGameTime=true
					ShowGlobalGameTime=true
					ShownNotifications=
					UpdateChannel=custom
					UseNativeGLFW=false
					UseNativeOpenAL=false
					WrapperCommand=
					)
				FileDelete, UltimMC\ultimmc.cfg
				FileAppend, %config%, UltimMC\ultimmc.cfg
				run, cmd.exe /c title SETUP && UltimMC\UltimMC, , Min
				start1:
				if WinExist("UltimMC Quick Setup - UltimMC 5"){
				downloading2:
				Sleep, 100
				if WinExist("UltimMC Quick Setup - UltimMC 5"){
					Goto, downloading2
					}
                if WinExist("SETUP")
				WinClose
                MsgBox, Java versiyonu başarıyla değiştirildi!
				}
				else{
				Goto, start1
				}
}
else {
    MsgBox, Lütfen öncelikle kurunuz.
}
ExitApp