@echo off
title Android Debugging Helper 

FOR /F "tokens=9 delims= " %%a in ('adb shell ip route') do (
	set deviceIp=%%a
)

if "%deviceIp%"=="" (
   echo No device found, please reinstert device and enable USB debugging
   timeout /t 5
) else (
   echo Device found
   echo Ip Address: %deviceIp%
)

set /p port="Set Port Address(0-65535): "

FOR /F "delims=" %%b in ('netstat -ano ^| find "%port%"') do (
	set portstatus=%%b
)

if "%portstatus%" == "" (
   echo Port is unsused, activating connecting port %port%
) else (
   echo Port is used, please choose a new port
   timeout 10
)

set newIp=%deviceIp%:%port%
adb tcpip %port%
adb connect %newIp%

pause
