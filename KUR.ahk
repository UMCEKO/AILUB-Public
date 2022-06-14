#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

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
				FileDelete, UltimMC\ultimmc.cfg
				FileDelete, UltimMC\accounts.json
				FileRemoveDir, UltimMC\instances, 1
				FileRemoveDir, UltimMC\cache, 1
				run, cmd.exe /c title SETUP && UltimMC\UltimMC --import https://www.bit.ly/, , Min
				lang:
				if WinExist("UltimMC Quick Setup - UltimMC 5") {
					Send, {Enter}
					Sleep, 5000
					Send, {Tab}{Tab}{Tab}{Tab}%RAM%{Enter}
					Sleep, 1000
					Send, {Enter}
					Sleep, 1000
					Send, {Enter}
					Sleep, 1000
					Send, {Enter}
					Sleep, 1000
					Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Right}%Link%{Enter}
					downloading:
					Sleep, 1000
					if WinExist("Please wait... - UltimMC 5"){
						Goto, downloading
						}
					Send, {Tab}{Space}{Tab}{Tab}{Tab}{Enter}
					Sleep, 500
					Click, 472 96
					Sleep, 500
					Send, {Tab}%Name%{Tab}1{Tab}{Enter}
					account:
					Sleep, 100
					if WinExist("Add Account - UltimMC 5"){
						Goto, account
						}
					Sleep, 1000
					if WinExist("Settings - UltimMC 5")
						WinClose
					if WinExist("SETUP")
						WinClose
					FileDelete, Name.ini
					FileDelete, Link.ini
					FileDelete, .sl_password
					FileDelete, UltimMC\instances\%Link%\.minecraft\.sl_password
					IniWrite, %Name%, Name.ini, 1
					IniWrite, %Link%, Link.ini, 1
					FileAppend, %pass%, .sl_password
					FileCopy, .sl_password, UltimMC\instances\%Link%\.minecraft\
					MsgBox Başarıyla kuruldu.
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