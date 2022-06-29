#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
RegRead, Hostnm, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters, Hostname
MsgBox Made by Umut Cevdet Koçak (Discord: Umut#3333)
InputBox, Link, Kodu giriniz, Size discorddan verilen kodu giriniz (Örnek: 56FdaX7), , , 130
if (ErrorLevel = 0) {
	InputBox, RAM, RAM Miktarını giriniz, Kaç MB (megabyte) RAM vermek istediğinizi yazınız (Önerilen 3000)., , , 150, , , , , 3000
	if (ErrorLevel = 0) {
		InputBox, Name, İsminizi giriniz, Oyun içinde kullanacağınız ismi giriniz (Örnek: ArdaGaming), , , 130
		if (ErrorLevel = 0) {
			InputBox, Pass, Sunucu şifrenizi giriniz., Sunucu şifrenizi giriniz., HIDE, , 130,
			if (ErrorLevel = 0) {
				MsgBox, Lütfen kurulum süresince hiçbirşeye tıklamayınız.
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
					downloading:
					if WinExist("Please wait... - UltimMC 5"){
						Goto, downloading
						}
					Sleep, 100
					if WinExist("SETUP")
						WinClose
					FileDelete, Name.ini
					FileDelete, Link.ini
					FileDelete, RAM.ini
					FileDelete, .sl_password
					FileDelete, UltimMC\instances\%Link%\.minecraft\.sl_password
					IniWrite, %RAM%, RAM.ini, 1
					IniWrite, %Name%, Name.ini, 1
					IniWrite, %Link%, Link.ini, 1
					FileAppend, %pass%, .sl_password
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