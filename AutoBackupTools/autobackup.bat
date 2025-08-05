@echo off
echo Batch File by MrWindows

mkdir "C:\startupbackupsystem"
echo.
xcopy /s "%~dp0.\startup\backupgood.bat" "C:\startupbackupsystem"
xcopy /s "%~dp0.\startup\create_services_backup.vbs" "C:\startupbackupsystem"
xcopy /s "%~dp0.\startup\clearbackupgood.bat" "C:\startupbackupsystem"
echo.

takeown /F "C:\startupbackupsystem" /R

:: Запрос выбора типа запуска
echo.
echo.
echo Выберите тип запуска задачи:
echo 1. При включении системы (рекомендую)
echo 2. Каждые N часов
echo 3. В определённое время дважды в день
set /p choice="Введите 1, 2 или 3: "

if %choice%==1 (
    goto :onlogon
) else if %choice%==2 (
    goto :hourly
) else if %choice%==3 (
    goto :daily
) else (
    echo Недопустимый выбор.
    pause
    exit /b
)

:onlogon
:: Создание задачи при включении системы
schtasks /create /tn "BackupTask" /sc onlogon /rl HIGHEST /f /tr C:\startupbackupsystem\backupgood.bat /np
echo.
echo Задача запланирована на запуск при включении системы.
:: Планирование автоматической очистки копий
echo.
echo Резервная копия весит порядком полу гигабайта. Есть необходимость также в автоматической очистки:
echo 1. Автоматическая очистка не нужна
echo 2. Каждую неделю (рекомендую)
echo 3. Каждый месяц
set /p clearinput="Введите 1, 2 или 3: "

if %clearinput%==1 (
    goto :offclear
) else if %clearinput%==2 (
    goto :weekly
) else if %clearinput%==3 (
    goto :monthly
) else (
    echo Недопустимый выбор.
    pause
    exit /b
)

:offclear
:: Очистка - отключена
echo.
echo Автоматическая очистка - отключена. Путь резервных копий C:\backup\
pause
exit /b

:weekly
:: Каждую неделю
set /p startTime="Выбери день недели в формате MON - SUN или диапазон [MON - SUN...]. К примеру "FRI" - каждую пятницу: "
echo.
schtasks /create /tn "ClearBackupTask" /sc weekly /mo 1 /d %startTime% /st 00:00 /et 23:59 /rl HIGHEST /f /tr C:\startupbackupsystem\clearbackupgood.bat /np
echo.
echo Очистка запланирована на каждый %startTime%.
pause
exit /b

:monthly
:: Каждый месяц
set /p startTime="Выбери день месяца, указав число от 1 до 31: "
echo.
schtasks /create /tn "ClearBackupTask" /sc monthly /mo 1 /d %startTime% /st 00:00 /et 23:59 /rl HIGHEST /f /tr C:\startupbackupsystem\clearbackupgood.bat /np
echo.
echo Очистка запланирована на каждый %startTime% день месяца.
pause
exit /b

:hourly
:: Запрос времени запуска
echo.
set /p startTime="Запланировать на каждые N часов (в период от 1 до 23 часов): "
echo.

:: Создание задачи каждые N часов
schtasks /create /tn "BackupTask" /sc hourly /mo %startTime% /st 00:00 /et 23:59 /k /rl HIGHEST /f /tr C:\startupbackupsystem\backupgood.bat /np
echo.
echo Резервное копирование запланировано на каждые %startTime% часов.
:: Планирование автоматической очистки копий
echo.
echo Резервная копия весит порядком полу гигабайта. Есть необходимость также в автоматической очистки:
echo 1. Автоматическая очистка не нужна
echo 2. Каждую неделю (рекомендую)
echo 3. Каждый месяц
set /p clearinput="Введите 1, 2 или 3: "

if %clearinput%==1 (
    goto :offclear
) else if %clearinput%==2 (
    goto :weekly
) else if %clearinput%==3 (
    goto :monthly
) else (
    echo Недопустимый выбор.
    pause
    exit /b
)

:offclear
:: Очистка - отключена
echo.
echo Автоматическая очистка - отключена. Путь резервных копий C:\backup\
pause
exit /b

:weekly
:: Каждую неделю
set /p startTime="Выбери день недели в формате MON - SUN или диапазон [MON - SUN...]. К примеру "FRI" - каждую пятницу: "
echo.
schtasks /create /tn "ClearBackupTask" /sc weekly /mo 1 /d %startTime% /st 00:00 /et 23:59 /rl HIGHEST /f /tr C:\startupbackupsystem\clearbackupgood.bat /np
echo.
echo Очистка запланирована на каждый %startTime%.
pause
exit /b

:monthly
:: Каждый месяц
set /p startTime="Выбери день месяца, указав число от 1 до 31: "
echo.
schtasks /create /tn "ClearBackupTask" /sc monthly /mo 1 /d %startTime% /st 00:00 /et 23:59 /rl HIGHEST /f /tr C:\startupbackupsystem\clearbackupgood.bat /np
echo.
echo Очистка запланирована на каждый %startTime% день месяца.
pause
exit /b

:daily
:: Запрос времени запуска
set /p startTime="Введите время для первого запуска (в формате ЧЧ:ММ): "
echo.
set /p startTime2="Введите время для второго запуска (в формате ЧЧ:ММ): "
echo.
:: Создание задач в планировщике
schtasks /create /tn "BackupTask" /sc DAILY /st %startTime% /tr C:\startupbackupsystem\backupgood.bat /rl HIGHEST /f /np
echo.
schtasks /create /tn "BackupTask2" /sc DAILY /st %startTime2% /tr C:\startupbackupsystem\backupgood.bat /rl HIGHEST /f /np
echo.
echo Резервное копирование запланировано на %startTime% и %startTime2% каждый день.
:: Планирование автоматической очистки копий
echo.
echo Резервная копия весит порядком полу гигабайта. Есть необходимость также в автоматической очистки:
echo 1. Автоматическая очистка не нужна
echo 2. Каждую неделю (рекомендую)
echo 3. Каждый месяц
set /p clearinput="Введите 1, 2 или 3: "

if %clearinput%==1 (
    goto :offclear
) else if %clearinput%==2 (
    goto :weekly
) else if %clearinput%==3 (
    goto :monthly
) else (
    echo Недопустимый выбор.
    pause
    exit /b
)

:offclear
:: Очистка - отключена
echo.
echo Автоматическая очистка - отключена. Путь резервных копий C:\backup\
pause
exit /b

:weekly
:: Каждую неделю
set /p startTime="Выбери день недели в формате MON - SUN или диапазон [MON - SUN...]. К примеру "FRI" - каждую пятницу: "
echo.
schtasks /create /tn "ClearBackupTask" /sc weekly /mo 1 /d %startTime% /st 00:00 /et 23:59 /rl HIGHEST /f /tr C:\startupbackupsystem\clearbackupgood.bat /np
echo.
echo Очистка запланирована на каждый %startTime%.
pause
exit /b

:monthly
:: Каждый месяц
set /p startTime="Выбери день месяца, указав число от 1 до 31: "
echo.
schtasks /create /tn "ClearBackupTask" /sc monthly /mo 1 /d %startTime% /st 00:00 /et 23:59 /rl HIGHEST /f /tr C:\startupbackupsystem\clearbackupgood.bat /np
echo.
echo Очистка запланирована на каждый %startTime% день месяца.
pause
exit /b

pause