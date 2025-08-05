rem от MrWindows
@echo off
@chcp 65001

echo Made by MrWindows
echo.
echo ===========================
echo Clear Backup System Files
echo ===========================
echo.

echo.
echo Очистка копий...

:: Очистка резервных копий
@RD /s /q "C:\backup\"
:: Запуск резервного копирования
schtasks /run /tn "BackupTask"
echo Done