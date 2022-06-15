#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
IniRead, Link, Link.ini, 1
IniRead, Name, Name.ini, 1
run, cmd.exe /c "%A_ScriptDir%\UltimMC\UltimMC" --launch %Link% --profile %Name% --server %ip%, , Hide
FileDelete, ip.ini
IniWrite, %ip%, ip.ini, 1
