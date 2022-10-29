#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
MsgBox, ,%launchername% ,Made by Umut Cevdet Koçak (Discord: Umut#3333)


; Where to pull the bit.ly codes from
database = https://raw.githubusercontent.com/umut25/AILUBModpackDB/main/AllTheMods8.txt
; Enable the discord button? (default: enablediscord = true)
enablediscord = false
; Your discord adress
discord = https://discord.gg/kGVTHS24ch
; Recommended ram for your pack
recram = 8192
; Do you want your players to use simplelogin passwords?
reqpass = false
; Enable Custom ip's? (default: enablecustomip = false)
enablecustomip = true
; Custom ip that the launcher will connect when the game starts
customip = 193.35.154.49:25565
; Name of the launcher
launchername = ATM8
; Auto start when the game gets installed? (default: autostart = false)
autostart = false
;Which java version to use? (options; 8,17+)
defjava = 17


UrlDownloadWithBar(Url,Name)
{
	While(){
		if FileExist(Name){
			MsgBox, 4,,Kurulum yerinde %Name% isimli dosya bulunmaktadır kurulumun devam edebilmesi için bu dosyanın silinmesi gerekmektedir. Silinsin mi?
			IfMsgBox, Yes
			FileDelete, %Name%
			IfMsgBox, No
			ExitApp
		}
		else{
			Break
		}
	}
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
		Sleep, 200
		FileGetSize, FutureSize, %Name%
		Speed:=Round(((FutureSize-CurrSize)*5)/1024)
	}
	Progress, Off
}


if NOT FileExist("Resources\config.ini"){
FileCreateDir, Resources
FileAppend,,Resources\config.ini
}
UrlDownloadToFile, %database%, Resources\NewVer.txt
if(ErrorLevel==1){
	MsgBox, İnternetiniz yoktur!
	Goto, Start
}
FileRead,NewVer,Resources\NewVer.txt
IniWrite, %NewVer%, Resources\config.ini, 1, NewVerTemp
FileDelete, Resources\NewVer.txt
IniRead, NewVer, Resources\config.ini, 1, NewVerTemp

LoopW=1
While(LoopW==1){
	JavaPathRaw:=""
	if(defjava==8){
        RegRead, JavaPathRaw, HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment\1.8, JavaHome
        if(ErrorLevel==1){
            MsgBox, 4,,Uyarı! Sizde java 8 bulunmamaktadır. Java yüklemek ister misiniz?,
            IfMsgBox, Yes
            MBOX=Yes
            if(MBOX==Yes){
                Gui, Cancel
                UrlDownloadWithBar("https://github.com/umut25/AILUB-Public/releases/download/java/jre-8u341-windows-x64.exe","Javaİndirici.exe")
                RunWait, Javaİndirici.exe
                FileDelete, Javaİndirici.exe
            }
			else{
				JavaPath:=""
			}
        }
        else{
            LoopW=0
        }
    }
	else if(defjava>=17){
		RegRead, JDKCV, HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\JDK, CurrentVersion
		if(ErrorLevel==0){
			StringLeft, JDKTCV, JDKCV, 2
			if(JDKTCV<17){
				MsgBox, 4,,Uyarı! Sizde java 17 ve üstü bulunmamaktadır. Java yüklemek ister misiniz?,
				IfMsgBox, Yes
				MBOX=Yes
				if(MBOX=="Yes"){
					UrlDownloadWithBar("https://github.com/umut25/AILUB-Public/releases/download/java/jdk-17.0.5_windows-x64_bin.exe","Javaİndirici.exe")
					RunWait, Javaİndirici.exe
					FileDelete, Javaİndirici.exe
				}
				else{
					LoopW=0
					JavaPath:=""
				}
			}
			else if(JDKTCV>=17){
				RegRead, JavaPathRaw, HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\JDK\%JDKCV%, JavaHome
			}
		}
		else if(ErrorLevel==1){
				MsgBox, 4,,Uyarı! Sizde java 17 ve üstü bulunmamaktadır. Java yüklemek ister misiniz?,
				IfMsgBox, Yes
				MBOX=Yes
				if(MBOX=="Yes"){
					UrlDownloadWithBar("https://github.com/umut25/AILUB-Public/releases/download/java/jdk-17.0.5_windows-x64_bin.exe","Javaİndirici.exe")
					RunWait, Javaİndirici.exe
					FileDelete, Javaİndirici.exe
				}
		}
	}
	StringReplace, JavaPathRawE, JavaPathRaw,\,/, All
	JavaPath=%JavaPathRawE%/bin/javaw.exe

	if(FileExist(JavaPath)){
		LoopW=0
	}
	else if(JavaPathRaw==""){
	}
	else{
		MsgBox, UYARI! JAVANIZ BOZUKTUR!
		LoopW=0
	}
}

if NOT (FileExist("Resources\config.ini") && FileExist("UltimMC")) {
	MsgBox, 4, , Oyun kurulu değil, kurmak ister misiniz?
	ifMsgBox, Yes
	Goto, ButtonKur
}

if (FileExist("Resources\config.ini") && FileExist("UltimMC")){
IniRead, CurVer, Resources\config.ini, 1, CurVer
if (NewVer != CurVer) {
	MsgBox, 4, , Oyun güncel değil, güncellemek ister misiniz?
	ifMsgBox, Yes
	Goto, ButtonGüncelle
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
if (reqpass==true){
Gui, Add, Button, , ŞifreDeğiştir
}
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
    IniRead, CurVer, Resources\config.ini, 1, CurVer
    IniRead, Name, Resources\config.ini, 1, Name
	if (enablecustomip == "false"){
		InputBox, ip, Sunucu adresini giriniz, Sunucu adresini giriniz. (Örnek: %customip%); Boş bırakırsanız ana menüye atar., , , 140, , , , , %def%
			if (ErrorLevel = 0) {
				if (ip = "") {
					run, cmd.exe /c "%A_ScriptDir%\UltimMC\UltimMC" --launch %CurVer% --profile %Name%, , Hide
					IniWrite, "", Resources\config.ini, 1, ip
					}
				else {
					run, cmd.exe /c "%A_ScriptDir%\UltimMC\UltimMC" --launch %CurVer% --profile %Name% --server %ip%, , Hide
					IniWrite, %ip%, Resources\config.ini, 1, ip
					}
			}
			else{
					Goto, Start
				}
	}
	else if (enablecustomip == "true"){
		run, cmd.exe /c "%A_ScriptDir%\UltimMC\UltimMC" --launch %CurVer% --profile %Name% --server %customip%, , Hide
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
IniRead, CurVer, Resources\config.ini, 1, CurVer
FileMoveDir, UltimMC\instances\%CurVer%\.minecraft, files, 2
FileRemoveDir, files\mods, 1
FileRemoveDir, files\config, 1
FileRemoveDir, files\defaultconfigs, 1
FileRemoveDir, files\packmenu, 1
if (reqpass==true){
FileDelete, files\.sl_password
}
FileRemoveDir, UltimMC\instances, 1
run, cmd.exe /c title SETUP && UltimMC\UltimMC --import https://www.bit.ly/%NewVer%, , HIDE
WinWait,New Instance - UltimMC 5
ControlSend, , {Enter}, New Instance - UltimMC 5
WinWait,Please wait... - UltimMC 5
WinWaitClose,Please wait... - UltimMC 5
if WinExist("ahk_exe UltimMC.exe")
WinClose, ahk_exe UltimMC.exe
IniWrite, %NewVer%, Resources\config.ini, 1, CurVer
FileCopyDir, files, UltimMC\instances\%NewVer%\.minecraft, 1
if (reqpass==true){
IniRead, pass, Resources\config.ini, 1, Password
FileDelete, UltimMC\instances\%NewVer%\.minecraft\.sl_password
FileAppend, %pass%, UltimMC\instances\%NewVer%\.minecraft\.sl_password
}
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
if (reqpass==true){
Gui, Add, Text,, Oyundaki şifrenizi giriniz:
Gui, Add, Edit,Password vPass,
}
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
if()
errortest=%ErrorLevel%
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
		JavaPath=%JavaPath%
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
if NOT FileExist(A_ScriptDir "\Resources")
FileCreateDir, Resources
RunWait, cmd.exe /c unzip UltimMCzipped.zip, , HIDE
FileDelete, unzip.exe
FileDelete, UltimMCzipped.zip
FileAppend, %account%, UltimMC\accounts.json
FileAppend, %config%, UltimMC\ultimmc.cfg
run, cmd.exe /c title SETUP && UltimMC\UltimMC --import https://www.bit.ly/%NewVer%, , HIDE
WinWait,New Instance - UltimMC 5
Sleep, 100
ControlSend, , {Enter}, New Instance - UltimMC 5
WinWait Please wait... - UltimMC 5
WinWaitClose Please wait... - UltimMC 5
WinClose, ahk_exe UltimMC.exe
if WinExist("ahk_exe UltimMC.exe")
FileCreateDir, Resources
IniWrite, %RAM%, Resources\config.ini, 1, RAM
IniWrite, %Name%, Resources\config.ini, 1, Name
IniWrite, %NewVer%, Resources\config.ini, 1, CurVer
IniWrite, true, Resources\config.ini, 1, Installed
if (reqpass==true){
IniWrite, %pass%, Resources\config.ini, 1, Password
}
IniWrite, %customip%, Resources\config.ini, 1, ip
if (reqpass==true){
FileAppend, %pass%, UltimMC\instances\%NewVer%\.minecraft\.sl_password
}
if FileExist("UltimMC\instances\" NewVer) {
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
		JavaPath=%JavaPath%
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
IniRead, CurVer, Resources\config.ini, 1, CurVer
Run, UltimMC\instances\%CurVer%\.minecraft\
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
		
		IniRead, CurVer, Resources\config.ini, 1, CurVer
		FileDelete, UltimMC\instances\%CurVer%\.minecraft\.sl_password
		FileAppend, %Pass%, UltimMC\instances\%CurVer%\.minecraft\.sl_password
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
