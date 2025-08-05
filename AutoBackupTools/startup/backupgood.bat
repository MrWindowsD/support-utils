rem от MrWindows
@echo off
@chcp 65001

echo Made by MrWindows
echo.
echo ===========================
echo Backup System Files
echo ===========================
echo.

echo ===========================
echo Путь: C:\backup\...
echo ===========================
echo.

:: Проверка и включение необходимых служб
echo Проверка и включение необходимых служб...
echo.
echo Запуск Volume Shadow Copy
sc query VolSnap | findstr "RUNNING" || sc start VolSnap
echo Запуск Microsoft Software Shadow Copy Provider
sc query VSS | findstr "RUNNING" || sc start VSS
echo Запуск службы архивации данных Windows (Windows Backup)
net start "Windows Backup" >nul 2>&1 || net start "Windows Backup"
echo Запуск службы восстановления системы (System Restore Service)
net start "System Restore Service" >nul 2>&1 || net start "System Restore Service"
echo Запуск службы теневого копирования томов (Volume Shadow Copy Service)
net start "Volume Shadow Copy Service" >nul 2>&1 || net start "Volume Shadow Copy Service"
echo Запуск службы удалённого реестра (Remote Registry Service)
net start "Remote Registry" >nul 2>&1 || net start "Remote Registry"

echo.
echo Создание резервной копии реестра...

:: Создание резервной копии реестра
set "backupDir=C:\backup\registry"
set "dateStamp=%date:~0,2%.%date:~3,2%.%date:~6,4%"
set "backupPath=%backupDir%\%dateStamp%"
mkdir "%backupPath%"

set "regBackupFile=%backupPath%\system_registry_backup.reg"
set "regBackupDir=%backupDir%"

if exist "%regBackupFile%" (
    echo Резервная копия реестра уже существует. Перезаписываем...
    del "%regBackupFile%"
)

reg export HKLM "%regBackupFile%"

echo.
echo Создание резервной копии служб...

:: Создание резервной копии служб
set "servicesBackupDir=C:\backup\services"
set "servicesBackupPath=%servicesBackupDir%\%dateStamp%"
mkdir "%servicesBackupPath%"

:: Инициализация скрипта для создания резервной копии служб
cscript //nologo "%~dp0create_services_backup.vbs" "%servicesBackupPath%\services_backup.reg"
echo.
echo Done