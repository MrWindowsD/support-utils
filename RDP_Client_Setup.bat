@echo off
echo Batch File by MrWindows

chcp 65001 > nul
:: chcp 1251 > nul

setlocal enabledelayedexpansion
color 0a
title RDP Client Setup (Windows 11 Pro)
mode con: cols=80 lines=25

:: Проверка прав администратора
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ОШИБКА] Требуются права администратора!
    echo Запустите скрипт от имени администратора
    pause
    exit /b
)

echo ================================================
echo    НАСТРОЙКА КЛИЕНТА УДАЛЁННОГО ДОСТУПА (RDP)
echo ================================================
echo Операционная система: Windows 11 Pro
echo ================================================

:: Создание лог-файла с использованием WMIC для получения даты в формате YYYYMMDD_HHMMSS
for /f "tokens=2 delims==." %%i in ('wmic os get localdatetime /value') do set now=%%i
set logfile=%USERPROFILE%\Desktop\RDP_Client_Log_%now:~0,8%_%now:~8,6%.txt
echo [%time%] Начало настройки клиента RDP > "%logfile%"

:: Проверка сетевых компонентов
echo Проверка сетевых компонентов...
echo [%time%] Проверка сетевых компонентов >> "%logfile%"
ipconfig /all >> "%logfile%"
netsh interface show interface >> "%logfile%"
echo ✓ Сетевые компоненты проверены

:: Включение необходимых компонентов
echo Включение компонентов Windows...
dism /online /Enable-Feature /FeatureName:RemoteDesktopClient /All /NoRestart >> "%logfile%" 2>&1
echo [%time%] Компонент RemoteDesktopClient включен >> "%logfile%"
echo ✓ Компоненты RDP активированы

:: Проверка доступности telnet
echo Проверка telnet-клиента...
dism /online /Enable-Feature /FeatureName:TelnetClient /All /NoRestart >> "%logfile%" 2>&1
echo [%time%] Telnet Client включен >> "%logfile%"
echo ✓ Telnet-клиент активирован

:: Финальный тест
echo.
echo ===== ТЕСТИРОВАНИЕ КЛИЕНТА =====
set /p target_ip=Введите IP целевого устройства: 
if "%target_ip%"=="" (
    echo [ОШИБКА] IP-адрес не введён!
    echo [%time%] ОШИБКА: IP-адрес не введён >> "%logfile%"
    pause
    exit /b
)
echo [%time%] Тестирование подключения к %target_ip% >> "%logfile%"

echo.
echo Тест ping...
ping -n 4 %target_ip% >> "%logfile%"
if %errorlevel% equ 0 (
    echo ✓ Устройство доступно в сети
    echo [%time%] Устройство %target_ip% доступно по ping >> "%logfile%"
) else (
    echo ⚠ Ошибка: устройство не отвечает на ping
    echo [%time%] ОШИБКА: Устройство %target_ip% недоступно по ping >> "%logfile%"
)

echo.
echo Тест порта 3389...
(echo quit | telnet %target_ip% 3389) >> "%logfile%" 2>&1
if %errorlevel% equ 0 (
    echo ✓ Порт 3389 открыт
    echo [%time%] Порт 3389 на %target_ip% доступен >> "%logfile%"
) else (
    echo ⚠ Ошибка: порт 3389 закрыт или недоступен
    echo [%time%] ОШИБКА: Порт 3389 на %target_ip% недоступен >> "%logfile%"
)

echo.
echo Настройка завершена! Лог сохранён: %logfile%
echo Для подключения используйте mstsc.exe
echo.
echo [%time%] Настройка клиента завершена >> "%logfile%"
pause
