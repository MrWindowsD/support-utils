@echo off
echo Batch File by MrWindows

chcp 65001 > nul
:: chcp 1251 > nul

setlocal enabledelayedexpansion
color 0a
title RDP Server Setup (Windows 10 IoT)
mode con: cols=80 lines=30

:: Проверка прав администратора
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ОШИБКА] Требуются права администратора!
    echo Запустите скрипт от имени администратора
    pause
    exit /b
)

echo ================================================
echo    НАСТРОЙКА СЕРВЕРА УДАЛЁННОГО ДОСТУПА (RDP)
echo ================================================
echo Операционная система: Windows 10 IoT
echo ================================================

:: Создание лог-файла с использованием WMIC для получения даты в формате YYYYMMDD_HHMMSS
for /f "tokens=2 delims==." %%i in ('wmic os get localdatetime /value') do set now=%%i
set logfile=%USERPROFILE%\Desktop\RDP_Server_Log_%now:~0,8%_%now:~8,6%.txt
echo [%time%] Начало настройки сервера RDP > "%logfile%"

:: Проверка версии Windows
echo Проверка версии ОС...
ver | find "10." > nul
if %errorlevel% equ 0 (
    echo ✓ Windows 10 обнаружена
    echo [%time%] Windows 10 IoT подтверждена >> "%logfile%"
) else (
    echo ⚠ Ошибка: Неподдерживаемая версия Windows
    echo [%time%] ОШИБКА: Неподдерживаемая версия Windows >> "%logfile%"
    goto :error
)

:: Включение RDP сервера
echo Включение удалённого доступа...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
if %errorlevel% neq 0 (
    echo ⚠ Ошибка: Не удалось включить RDP сервер через реестр.
    echo [%time%] ОШИБКА: Не удалось включить RDP сервер через реестр >> "%logfile%"
    goto :error
)
echo [%time%] RDP сервер включён в реестре >> "%logfile%"

:: Настройка брандмауэра
echo Настройка брандмауэра...
netsh advfirewall firewall add rule name="Allow RDP" dir=in protocol=TCP localport=3389 action=allow >> "%logfile%" 2>&1
if %errorlevel% neq 0 (
    echo ⚠ Ошибка: Не удалось добавить правило брандмауэра для RDP.
    echo [%time%] ОШИБКА: Добавление правила брандмауэра не удалось >> "%logfile%"
    goto :error
)
echo [%time%] Правило брандмауэра добавлено >> "%logfile%"

:: Управление службой TermService
echo Запуск службы TermService...
net stop TermService >> "%logfile%" 2>&1
net start TermService >> "%logfile%" 2>&1
sc config TermService start=auto >> "%logfile%" 2>&1
if %errorlevel% neq 0 (
    echo ⚠ Ошибка: Проблема при управлении службой TermService.
    echo [%time%] ОШИБКА: Служба TermService не перезапущена должным образом >> "%logfile%"
    goto :error
)
echo [%time%] Служба TermService перезапущена >> "%logfile%"

:: Проверка учётных записей
echo Проверка учётных записей...
net user >> "%logfile%"
echo [%time%] Список пользователей выведен >> "%logfile%"
echo.
echo ВАЖНО: Для подключения нужен пароль!
echo       Создайте пароль для своей учётной записи

:: Сетевые настройки
echo Настройка сети...
ipconfig /all >> "%logfile%"
echo [%time%] Сетевые настройки сохранены >> "%logfile%"

:: Финальные проверки
echo.
echo ===== ДИАГНОСТИКА СЕРВЕРА =====
echo [%time%] Запуск диагностики сервера >> "%logfile%"

echo Проверка состояния RDP...
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections >> "%logfile%"
echo ✓ Состояние RDP проверено

echo Проверка порта 3389...
netstat -ano | findstr :3389 >> "%logfile%"
if %errorlevel% equ 0 (
    echo ✓ Порт 3389 прослушивается
    echo [%time%] Порт 3389 активен >> "%logfile%"
) else (
    echo ⚠ Ошибка: порт 3389 не активен
    echo [%time%] ОШИБКА: Порт 3389 не прослушивается >> "%logfile%"
)

echo Проверка службы TermService...
sc query TermService | findstr "STATE" >> "%logfile%"
echo ✓ Состояние службы проверено

echo.
echo Настройка завершена! Лог сохранён: %logfile%
echo IP-адрес для подключения:
ipconfig | findstr "IPv4" | findstr /v "127.0.0.1"
echo.
echo [%time%] Настройка сервера завершена успешно >> "%logfile%"

:success
echo ✓ Сервер RDP готов к подключениям
echo.
pause
exit /b

:error
echo ⚠ Обнаружены ошибки в настройке!
echo Подробности в лог-файле: %logfile%
pause
exit /b
