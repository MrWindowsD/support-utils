@echo off
echo Batch File By MrWindows
echo.

schtasks /delete /tn "BackupTask" /f
schtasks /delete /tn "BackupTask2" /f
schtasks /delete /tn "ClearBackupTask" /f

@RD /s /q "C:\startupbackupsystem"
echo.
echo bat 䠩� �ᯥ譮 㤠���!
pause