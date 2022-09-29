#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
MsgBox, ,%launchername% ,Made by Umut Cevdet Koçak (Discord: Umut#3333)


; Where to pull the bit.ly codes from
database = https://github.com/umut25/databasetest/raw/main/KC2.ini
; Enable the discord button? (default: enablediscord = true)
enablediscord = true
; Your discord adress
discord = https://discord.gg/kGVTHS24ch
; Recommended ram for your pack
recram = 2000
; Enable Custom ip's? (default: enablecustomip = false)
enablecustomip = false
; Custom ip that the launcher will connect when the game starts
customip = oculeth.knightcraft.cf
; Name of the launcher
launchername = AILUB
; Auto start when the game gets installed? (default: autostart = false)
autostart = false


UrlDownloadWithBar(Url,Name)
{
WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
WebRequest.Open("HEAD", Url)
WebRequest.Send()
FinalSize := WebRequest.GetResponseHeader("Content-Length")
CurrSize=0
Run, powershell (New-Object Net.WebClient).DownloadFile('%Url%'`, '%A_ScriptDir%\%Name%'),, HIDE
Progress, On H70
__UpdateProgressBar:
While(FinalSize!=CurrSize){
    FileGetSize, CurrSize, %Name%
    Percentage := (CurrSize/FinalSize)*100
    ProgressFinalSize:=Round((FinalSize)/1024)
    ProgressCurrSize:=Round((CurrSize)/1024)
    Progress, %Percentage%,%Speed%KB/s %ProgressCurrSize%KB/%ProgressFinalSize%KB `n %Name% indiriliyor
    Sleep, 100
    FileGetSize, FutureSize, %Name%
    Speed:=Round(((FutureSize-CurrSize)*10)/1024)
}
Progress, Off
}


if NOT (FileExist("Resources\config.ini") && FileExist("UltimMC")) {
	MsgBox, 4, , Oyun kurulu değil, kurmak ister misiniz?
	ifMsgBox, Yes
	Goto, ButtonKur
	ifMsgBox, No
	Goto, Start
}
if (FileExist("Resources\config.ini") && FileExist("UltimMC")){
IniRead, Link, Resources\config.ini, 1, Link
UrlDownloadToFile, %database%, Resources\updchk.ini
FileRead, updkod, Resources\updchk.ini
FileDelete, Resources\updchk.ini
if (updkod != Link) {
	MsgBox, 4, , Oyun güncel değil, güncellemek ister misiniz?
	ifMsgBox, Yes
	Goto, ButtonGüncelle
	ifMsgBox, No
	Goto, Start
}
}
if (FileExist("unzip.exe") || FileExist("UltimMCzipped.zip")){
	MsgBox, %launchername% Dosyalarında bir hata algılandı!
	Goto, ButtonSıfırla
}

Start:
Gui, New
Gui, Add, Tab3,, Genel|Gelişmiş|Sıfırlama
Gui, Tab, 1
Gui, Add, Text,, Lütfen yapacağınız işlemi aşağıdan seçiniz. 
Gui, Add, Button, default, Çalıştır
Gui, Add, Button, , Güncelle
Gui, Add, Button,  x104 y53, Kur
if (enablediscord == "true")
Gui, Add, Button, , Discord
Gui, Add, Button,  x23 y140 W200, İptal

Gui, Tab, 2
Gui, Add, Text,, Lütfen yapacağınız işlemi aşağıdan seçiniz. 
Gui, Add, Button, , Ayarlar
Gui, Add, Button, , OyunKlasörü
Gui, Add, Button, , İsimDeğiştir
Gui, Add, Button,  x104 y53, AyarÇek
Gui, Add, Button, , ŞifreDeğiştir
Gui, Add, Button, , JavaKurulum
Gui, Add, Button, x23 y140 W200, İptal

Gui, Tab, 3
Gui, Add, Text,, Sıfırlamak istediğinize emin misiniz?
Gui, Add, Button, y53 x23 W200 H80, Sıfırla
Gui, Add, Button, x23 y140 W200 , İptal
Gui, Show, , %launchername%

return

GuiClose:
ExitApp

Buttonİptal:
ExitApp

ButtonÇalıştır:
if (FileExist("Resources\config.ini") && FileExist("UltimMC")) {
	Gui, Cancel
	if WinExist("ahk_exe UltimMC.exe")
	WinClose, ahk_exe UltimMC.exe
    IniRead, def, Resources\config.ini, 1, ip
    IniRead, Link, Resources\config.ini, 1, Link
    IniRead, Name, Resources\config.ini, 1, Name
	if (enablecustomip == "false"){
		InputBox, ip, Sunucu adresini giriniz, Sunucu adresini giriniz. (Örnek: %customip%); Boş bırakırsanız ana menüye atar., , , 140, , , , , %def%
			if (ErrorLevel = 0) {
				if (ip = "") {
					run, cmd.exe /c "%A_ScriptDir%\UltimMC\UltimMC" --launch %Link% --profile %Name%, , Hide
					IniWrite, "", Resources\config.ini, 1, ip
					}
				else {
					run, cmd.exe /c "%A_ScriptDir%\UltimMC\UltimMC" --launch %Link% --profile %Name% --server %ip%, , Hide
					IniWrite, %ip%, Resources\config.ini, 1, ip
					}
			}
			else{
					Goto, Start
				}
	}
	else if (enablecustomip == "true"){
		run, cmd.exe /c "%A_ScriptDir%\UltimMC\UltimMC" --launch %Link% --profile %Name% --server %customip%, , Hide
	}
	else{
	MsgBox, enablecustomip variable is invalid.
	}
}
else {
    MsgBox, Lütfen öncelikle kurunuz.
	return
}
ExitApp


ButtonGüncelle:
if (FileExist("Resources\config.ini") && FileExist("UltimMC")) {
Gui, Cancel
if WinExist("ahk_exe UltimMC.exe")
WinClose, ahk_exe UltimMC.exe
UrlDownloadToFile, %database%, Resources\kod.ini
FileRead, kod, Resources\kod.ini 
FileDelete, Resources\kod.ini
IniWrite, %kod%, Resources\config.ini, 1, kod
IniRead, Link, Resources\config.ini, 1, Link
FileMoveDir, UltimMC\instances\%Link%\.minecraft, files, 2
FileRemoveDir, files\mods, 1
FileRemoveDir, files\config, 1
FileRemoveDir, files\defaultconfigs, 1
FileRemoveDir, files\packmenu, 1
FileDelete, files\.sl_password
FileRemoveDir, UltimMC\instances, 1
run, cmd.exe /c title SETUP && UltimMC\UltimMC --import https://www.bit.ly/%kod%, , HIDE
instance:
if WinExist("New Instance - UltimMC 5"){
Sleep, 100
ControlSend, , {Enter}, New Instance - UltimMC 5
adlkfj:
if WinExist("Please wait... - UltimMC 5"){
downloading:
Sleep, 100
if WinExist("Please wait... - UltimMC 5"){
Goto, downloading
}
if WinExist("ahk_exe UltimMC.exe")
WinClose, ahk_exe UltimMC.exe
IniWrite, %kod%, Resources\config.ini, 1, Link
FileCopyDir, files, UltimMC\instances\%kod%\.minecraft, 1
IniRead, pass, Resources\config.ini, 1, Password
FileDelete, UltimMC\instances\%kod%\.minecraft\.sl_password
FileAppend, %pass%, UltimMC\instances\%kod%\.minecraft\.sl_password
FileRemoveDir, files, 1
if(autostart == "false"){
	MsgBox Güncelleme tamamlandı
	Goto, Start
}
else if(autostart == "true"){
	Goto, ButtonÇalıştır
}
else{
	MsgBox, Variable error!
}
}
else{
	Goto, adlkfj
}
}
else{
	goto, instance
}
}
else {
    MsgBox, Lütfen öncelikle kurunuz.
	return
}
ExitApp


ButtonKur:
if (FileExist("Resources\config.ini") && FileExist("UltimMC")) {
MsgBox, Zaten kurulu.
return
}
Gui, Cancel
Gui, New
Gui, Add, Text,, Oyundaki adınızı giriniz:
Gui, Add, Edit, vName, 
Gui, Add, Text,, Oyundaki şifrenizi giriniz:
Gui, Add, Edit,Password vPass,
Gui, Add, Text,, Oyuna vereceğiniz bellek`nmiktarını MB cinsinden giriniz:
Gui, Add, Edit,W121 vRAM, %recram%
Gui, Add, Button,Default W121, Devam
Gui, Show, ,Kurulum
return
ButtonDevam:
Gui, Submit
Gui, Cancel
FileRemoveDir,Resources , 1
FileRemoveDir,UltimMC , 1
if WinExist("ahk_exe UltimMC.exe")
WinClose, ahk_exe UltimMC.exe
RegRead, Hostnm, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters, Hostname
RegRead, Java8Path, HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment\1.8, JavaHome
errortest=%ErrorLevel%
StringReplace, Java8, Java8Path, \ , /, All
if NOT errortest==0{
	MsgBox, 4,,Uyarı! Sizde java 8 bulunmamaktadır. Java yüklemek ister misiniz?,
	IfMsgBox, Yes
	{
		Gui, Cancel
		UrlDownloadWithBar("https://github.com/umut25/AILUB-Public/releases/download/java/jre-8u341-windows-x64.exe","Javaİndirici.exe")
		Progress, Off
		RunWait, Javaİndirici.exe
		FileDelete, Javaİndirici.exe
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
	}
	IfMsgBox, No
	{
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
	}
}
else{
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
	JavaPath=%Java8%/bin/javaw.exe
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
}
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
UrlDownloadWithBar("http://stahlworks.com/dev/unzip.exe", "unzip.exe")
UrlDownloadWithBar("https://github.com/umut25/databasetest/raw/main/UltimMCzipped.zip", "UltimMCzipped.zip")
if NOT FileExist("%A_ScriptDir%\Resources")
FileCreateDir, Resources
UrlDownloadToFile, %database%, Resources\kod.ini
FileRead, kod, Resources\kod.ini
FileDelete, Resources\kod.ini
IniWrite, %kod%, Resources\config.ini, 1, kod
RunWait, cmd.exe /c unzip UltimMCzipped.zip, , HIDE
FileDelete, unzip.exe
FileDelete, UltimMCzipped.zip
FileAppend, %account%, UltimMC\accounts.json
FileAppend, %config%, UltimMC\ultimmc.cfg
run, cmd.exe /c title SETUP && UltimMC\UltimMC --import https://www.bit.ly/%kod%, , HIDE

WinWait,New Instance - UltimMC 5
Sleep, 100
ControlSend, , {Enter}, New Instance - UltimMC 5
WinWait Please wait... - UltimMC 5
WinWaitClose Please wait... - UltimMC 5
WinClose, ahk_exe UltimMC.exe
FileCreateDir, Resources
IniWrite, %RAM%, Resources\config.ini, 1, RAM
IniWrite, %Name%, Resources\config.ini, 1, Name
IniWrite, %kod%, Resources\config.ini, 1, Link
IniWrite, true, Resources\config.ini, 1, Installed
IniWrite, %pass%, Resources\config.ini, 1, Password
IniWrite, %customip%, Resources\config.ini, 1, ip
FileAppend, %pass%, UltimMC\instances\%kod%\.minecraft\.sl_password
if FileExist("UltimMC\instances\" Link) {
	if(autostart == "false"){
	MsgBox, Başarıyla kuruldu!
	Goto, Start
	}
	else if(autostart == "true"){
	Goto, ButtonÇalıştır
	}
	else{
		MsgBox, Variable error!
	}
}
Else {
MsgBox, Kurulum Başarısız.
Goto, ButtonSıfırla
}
ExitApp


ButtonAyarlar:
if (FileExist("Resources\config.ini") && FileExist("UltimMC")) {
	Gui, Cancel
	if WinExist("ahk_exe UltimMC.exe")
	WinClose, ahk_exe UltimMC.exe
	RegRead, Hostnm, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters, Hostname
	IniRead, RAM, Resources\config.ini, 1, RAM
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
	run, cmd.exe /c title SETUP && UltimMC\UltimMC, , HIDE
	WinWait, UltimMC Quick Setup - UltimMC 5
	WinWaitClose, UltimMC Quick Setup - UltimMC 5
	WinWait, UltimMC 5 - Version 0.7.0-custom on win32 - UltimMC 5
	WinClose, ahk_exe UltimMC.exe
	MsgBox, Ayarlar başarıyla değiştirildi!
	Goto, Start
}
else {
    MsgBox, Lütfen öncelikle kurunuz.
	return
}
ExitApp
ButtonİsimDeğiştir:
if (FileExist("Resources\config.ini") && FileExist("UltimMC")) {
	Gui, Cancel
	InputBox, Name, Sunucuda kullanacağınız İsmi giriniz., Oyun isminizi giriniz., , , 130,
	if (ErrorLevel = 0) {

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
		FileDelete, UltimMC\accounts.json
		FileAppend, %account%, UltimMC\accounts.json
		IniWrite, %Name%, Resources\config.ini, 1, Name
		Goto, Start
	
		}
	else {
		Goto, Start
	}

}
else {
    MsgBox, Lütfen öncelikle kurunuz.
	return
}

ButtonSıfırla:
Gui, Cancel
if WinExist("ahk_exe UltimMC.exe")
WinClose, ahk_exe UltimMC.exe
FileDelete, UltimMCzipped.zip
FileDelete, unzip.exe
FileRemoveDir, UltimMC, 1
FileRemoveDir, Resources, 1
if NOT (FileExist("Resources") || FileExist("UltimMC") || FileExist("unzip.exe") || FileExist("UltimMCzipped.zip")){
MsgBox, Başarıyla sıfırlandı!
Goto, Start
ExitApp
}
else{
	MsgBox, Sıfırlama başarısız! %launchername% ile ilgili açık olan bütün dosyaları arkadan kapatın!
	Goto, Start
}
ButtonOyunKlasörü:
if (FileExist("Resources\config.ini") && FileExist("UltimMC")) {
IniRead, Link, Resources\config.ini, 1, Link
Run, UltimMC\instances\%Link%\.minecraft\
return
}
else {
    MsgBox, Lütfen öncelikle kurunuz.
	return
}
ButtonAyarÇek:
if (FileExist("Resources\config.ini") && FileExist("UltimMC")) {
Gui, Cancel
MsgBox, 4, , .minecraft'taki ayarlarınızı %launchername%'a aktarmak ister misiniz?
IfMsgBox Yes 
Goto, ayrlr
else
Goto, Start
ayrlr:
FileCopy, %A_AppData%\.minecraft\options.txt, UltimMC\instances\3Qvmya5\.minecraft\options.txt, 1
Goto, Start
}	
else {
    MsgBox, Lütfen öncelikle kurunuz.
	return
}
ButtonDiscord:
RunWait, cmd.exe /c explorer "%discord%", , HIDE
Goto, Start

ButtonŞifreDeğiştir:
if (FileExist("Resources\config.ini") && FileExist("UltimMC")) {
	Gui, Cancel
	InputBox, Pass, Serverda kullanacağınız şifreyi giriniz., Sunucu şifrenizi giriniz., HIDE, , 130,
	if (ErrorLevel = 0) {
		
		IniRead, Link, Resources\config.ini, 1, Link
		FileDelete, UltimMC\instances\%Link%\.minecraft\.sl_password
		FileAppend, %Pass%, UltimMC\instances\%Link%\.minecraft\.sl_password
		IniWrite, %Pass%, Resources\config.ini, 1, Password
		Goto, Start
	}
	else {
		Goto, Start
	}
}	
else {
    MsgBox, Lütfen öncelikle kurunuz.
	return
}


ButtonJavaKurulum:
Gui, Cancel
UrlDownloadWithBar("https://javadl.oracle.com/webapps/download/AutoDL?BundleId=246808_424b9da4b48848379167015dcc250d8d", "Javaİndirici.exe")
RunWait, Javaİndirici.exe
FileDelete, Javaİndirici.exe
Goto, Start