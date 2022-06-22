#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
RegRead, Hostnm, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters, Hostname
IniRead, RAM, RAM.ini, 1
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
				start:
				if WinExist("UltimMC Quick Setup - UltimMC 5"){
				downloading:
				Sleep, 100
				if WinExist("UltimMC Quick Setup - UltimMC 5"){
					Goto, downloading
					}
                if WinExist("SETUP")
				WinClose
                MsgBox, Java versiyonu başarıyla değiştirildi!
				}
				else{
				Goto, start
				}