#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
InputBox, Update, Kodu giriniz, Size discorddan verilen kodu giriniz (Örnek: 56FdaX7), , , 130
if (ErrorLevel = 0) {
IniRead, Link, Link.ini, 1
FileCopy, UltimMC\instances\%Link%\.minecraft\options.txt, options.txt
FileRemoveDir, UltimMC\instances, 1
run, cmd.exe /c title SETUP && UltimMC\UltimMC --import https://www.bit.ly/, , Min
Sleep, 2000
Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Right}%Update%{Enter}
downloading:
Sleep, 1000
if WinExist("Please wait... - UltimMC 5"){
Goto, downloading
}
if WinExist("SETUP")
	WinClose
FileDelete, Link.ini
IniWrite, %Update%, Link.ini, 1
FileCopy, .sl_password, UltimMC\instances\%Update%\.minecraft\
FileCopy, options.txt, UltimMC\instances\%Update%\.minecraft\
FileDelete, options.txt
MsgBox Güncelleme tamamlandı
}
else {
MsgBox, İşlemi iptal ettiniz.
}