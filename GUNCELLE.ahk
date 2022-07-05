#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
InputBox, Update, Kodu giriniz, Size discorddan verilen kodu giriniz (Örnek: 56FdaX7), , , 130
if (ErrorLevel = 0) {
IniRead, Link, Link.ini, 1
FileMoveDir, UltimMC\instances\%Link%\.minecraft, files, 2
FileRemoveDir, files\mods, 1
FileRemoveDir, files\config, 1
FileRemoveDir, files\defaultconfigs, 1
FileRemoveDir, files\packmenu, 1
FileRemoveDir, UltimMC\instances, 1
run, cmd.exe /c title SETUP && UltimMC\UltimMC --import https://www.bit.ly/%Update%, , Min
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
FileDelete, Link.ini
IniWrite, %Update%, Link.ini, 1
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
MsgBox, İşlemi iptal ettiniz.
}
