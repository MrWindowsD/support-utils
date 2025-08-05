@echo off
set LOGPATH="%USERPROFILE%\Desktop\OfficeInstall.log"
msiexec /i "C:\MS_Office_2010\MS_Office_2010\setup.exe" /L*v %LOGPATH%
pause