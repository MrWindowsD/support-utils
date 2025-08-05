@echo off
@chcp 65001 >nul

echo Made by MrWindows
echo.
echo ===========================
echo Начинаем диагностику сетевого адаптера...
echo ===========================
echo.
title Сетевая диагностика
color 0A

:: Проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Требуются права администратора! Запустите скрипт от имени администратора.
    pause
    exit /b 1
)

:menu
cls
echo 1. Полная перезагрузка сетевых компонентов
echo 2. Диагностика сети (выбор сайта)
echo 3. Выход
choice /c 123 /n /m "Выберите действие: "
if errorlevel 3 exit
if errorlevel 2 goto site_menu
if errorlevel 1 goto reset

:reset
echo Перезагрузка сетевых адаптеров...
powershell -Command "Get-NetAdapter | Restart-NetAdapter -Confirm:$false"

echo Включение службы WLAN AutoConfig...
sc config Wlansvc start= auto
net start Wlansvc

echo Сброс сетевых настроек...
netsh winsock reset catalog
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns

echo.
echo Операции завершены. Перезагрузка сетевого стека выполнена.
echo Для полного применения изменений рекомендуется перезагрузить компьютер.
echo.
pause
goto menu

:site_menu
cls
echo Выберите сайт для диагностики:
echo 1. vk.com
echo 2. mail.ru
echo 3. web.telegram.org
echo 4. yandex.ru
echo 5. Назад
choice /c 12345 /n /m "Ваш выбор: "
if errorlevel 5 goto menu
if errorlevel 4 set "site=yandex.ru" && goto diagnostics
if errorlevel 3 set "site=web.telegram.org" && goto diagnostics
if errorlevel 2 set "site=mail.ru" && goto diagnostics
if errorlevel 1 set "site=vk.com" && goto diagnostics

:diagnostics
cls
echo.
echo =================================
echo Тестирование %site%
echo =================================

echo [Пинг (4 запроса)]:
ping -n 4 %site% | findstr /i "loss"

echo.
echo [Трассировка (до 10 хопов)]:
tracert -d -h 10 -w 1000 "%site%"

echo.
echo [Оценка скорости (3 пакета по 64KB)]:
ping -n 3 -l 65500 %site% | findstr /i "loss"

echo.
echo Диагностика завершена.
pause
goto site_menu