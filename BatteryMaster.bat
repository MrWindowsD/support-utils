@echo off
echo Batch File by MrWindows

::BatteryMaster — мощный инструмент для диагностики, оптимизации и калибровки аккумуляторов ноутбуков под Windows 10/11. Скрипт объединяет системные утилиты Windows в удобном интерфейсе с автоматизацией сложных операций.


chcp 65001 > nul
:: chcp 1251 > nul

setlocal enabledelayedexpansion

:: Исправление кодировки: устанавливаем UTF-8 (при необходимости замените на chcp 1251)
chcp 65001 >nul

color 0a
title BatteryMaster: Оптимизация аккумулятора
mode con: cols=75 lines=25

:: Проверка ОС
ver | find "10." >nul
if %errorlevel% equ 0 set "winver=Windows 10"
ver | find "11." >nul
if %errorlevel% equ 0 set "winver=Windows 11"

:: Проверка прав администратора
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Требуются права администратора!
    echo Запустите скрипт от имени администратора.
    pause
    exit /b
)

:MAIN_MENU
cls
echo.
echo ================================================
echo          BATTERYMASTER - ОПТИМИЗАЦИЯ АККУМУЛЯТОРА
echo ================================================
echo Операционная система: %winver%
echo ================================================
echo 1. ДИАГНОСТИКА АККУМУЛЯТОРА
echo 2. ОТЧЁТ О СОСТОЯНИИ БАТАРЕИ
echo 3. ОТКЛЮЧИТЬ ФУНКЦИИ ЭНЕРГОСБЕРЕЖЕНИЯ
echo 4. РЕЖИМ МАКСИМАЛЬНОЙ ПРОИЗВОДИТЕЛЬНОСТИ
echo 5. КАЛИБРОВКА АККУМУЛЯТОРА
echo 6. ИСТОРИЯ ИСПОЛЬЗОВАНИЯ
echo 7. ОТКАТ НА ДЕФОЛТНЫЕ НАСТРОЙКИ
echo 8. ВЫХОД
echo ================================================
choice /c 12345678 /n /m "Выберите действие: "
if %errorlevel% equ 1 goto DIAGNOSTICS
if %errorlevel% equ 2 goto REPORT
if %errorlevel% equ 3 goto DISABLE_ECO
if %errorlevel% equ 4 goto MAX_PERF
if %errorlevel% equ 5 goto CALIBRATION
if %errorlevel% equ 6 goto USAGE_HISTORY
if %errorlevel% equ 7 goto ROLLBACK
if %errorlevel% equ 8 exit

:DIAGNOSTICS
cls
echo ЗАПУСК ДИАГНОСТИКИ АККУМУЛЯТОРА...
echo.
echo Анализ состояния батареи...

:: Генерация отчёта на рабочем столе
powercfg /batteryreport /output "%USERPROFILE%\Desktop\Battery_Report.html" >nul

:: Сбор данных из battery report (DesignCapacity, FullChargeCapacity, CycleCount)
set count=0
for /f "tokens=2 delims=:><" %%a in ('powercfg /batteryreport /xml ^| findstr "DesignCapacity FullChargeCapacity CycleCount"') do (
    set /a count+=1
    if !count! equ 1 set design=%%a
    if !count! equ 2 set full=%%a
    if !count! equ 3 set cycles=%%a
)

if "%design%"=="" (
    echo Ошибка: данные батареи не найдены.
    pause
    goto MAIN_MENU
)
if "%design%"=="0" (
    echo Ошибка: проектная ёмкость равна 0.
    pause
    goto MAIN_MENU
)

:: Расчёт состояния аккумулятора (в процентах)
set /a health=100 * full / design 2>nul

echo.
echo ===== РЕЗУЛЬТАТЫ ДИАГНОСТИКИ =====
echo Проектная ёмкость: %design% mWh
echo Текущая ёмкость: %full% mWh
echo Циклы зарядки: %cycles%
echo Состояние аккумулятора: %health%%%
if %health% lss 70 (
    echo ⚠ ВНИМАНИЕ: Аккумулятор изношен!
) else (
    echo ✓ Состояние аккумулятора в норме.
)

:: Дополнительная информация о батарее через WMIC
for /f "tokens=2 delims==" %%a in ('wmic path Win32_Battery get EstimatedChargeRemaining /value ^| find "="') do set "wmic_percent=%%a"
for /f "tokens=2 delims==" %%a in ('wmic path Win32_Battery get BatteryStatus /value ^| find "="') do set "wmic_status=%%a"
for /f "tokens=2 delims==" %%a in ('wmic path Win32_Battery get EstimatedRunTime /value ^| find "="') do set "runtime=%%a"
for /f "tokens=2 delims==" %%a in ('wmic path Win32_Battery get DesignVoltage /value ^| find "="') do set "voltage=%%a"
for /f "tokens=2 delims==" %%a in ('wmic path Win32_Battery get Chemistry /value ^| find "="') do set "chemistry=%%a"

set "status_desc=Неизвестно"
if "%wmic_status%"=="1" set "status_desc=Разряжается"
if "%wmic_status%"=="2" set "status_desc=Подключен к сети (не заряжается)"
if "%wmic_status%"=="3" set "status_desc=Полностью заряжен"
if "%wmic_status%"=="4" set "status_desc=Низкий заряд"
if "%wmic_status%"=="5" set "status_desc=Критический заряд"
if "%wmic_status%"=="6" set "status_desc=Заряжается"
if "%wmic_status%"=="7" set "status_desc=Заряжается (Высокий заряд)"
if "%wmic_status%"=="8" set "status_desc=Заряжается (Низкий заряд)"
if "%wmic_status%"=="9" set "status_desc=Заряжается (Критический)"
if "%wmic_status%"=="10" set "status_desc=Неопределено"

set "chemistry_desc=Неизвестно"
if "%chemistry%"=="3" set "chemistry_desc=Свинцово-кислотная"
if "%chemistry%"=="4" set "chemistry_desc=Никель-кадмиевая"
if "%chemistry%"=="5" set "chemistry_desc=Литий-ионная"
if "%chemistry%"=="6" set "chemistry_desc=Литий-полимерная"

echo.
echo ===== ПОДРОБНАЯ ИНФОРМАЦИЯ О БАТАРЕЕ (WMIC) =====
echo Текущий уровень заряда: %wmic_percent%%%
echo Статус батареи: %wmic_status% - %status_desc%
if defined runtime (
    echo Ориентировочное время работы: %runtime% мин.
) else (
    echo Ориентировочное время работы: недоступно
)
if defined voltage (
    echo Напряжение батареи: %voltage% мВ
)
echo Тип батареи: %chemistry_desc%
echo.
echo Отчёт сохранён на рабочем столе: Battery_Report.html
echo.
pause
goto MAIN_MENU

:REPORT
start "" "%USERPROFILE%\Desktop\Battery_Report.html"
goto MAIN_MENU

:DISABLE_ECO
cls
echo ОТКЛЮЧЕНИЕ ЭНЕРГОСБЕРЕЖЕНИЯ...
echo.
:: Отключение энергосбережения USB
powercfg /setdcvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul
powercfg /setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul
echo ✓ Отключено энергосбережение USB
:: Отключение адаптивной регулировки яркости
powercfg /setdcvalueindex SCHEME_CURRENT 7516b95f-f776-4464-8c53-06167f40cc99 fbd9aa66-9553-4097-ba44-ed6e9d65eab8 0 >nul
powercfg /setacvalueindex SCHEME_CURRENT 7516b95f-f776-4464-8c53-06167f40cc99 fbd9aa66-9553-4097-ba44-ed6e9d65eab8 0 >nul
echo ✓ Отключена адаптивная яркость
:: Отключение таймеров снижения производительности
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR 4b92d758-5a24-4851-a470-815d78aee119 0 >nul
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR 4b92d758-5a24-4851-a470-815d78aee119 0 >nul
echo ✓ Отключены таймеры снижения производительности
:: Отключение энергосбережения сетевого адаптера
for /f "tokens=*" %%i in ('powershell -command "Get-NetAdapter | Where-Object {$_.Status -eq 'Up'} | Select-Object -ExpandProperty Name"') do (
    powercfg /setdcvalueindex SCHEME_CURRENT 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a "%%i" 0 >nul
    powercfg /setacvalueindex SCHEME_CURRENT 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a "%%i" 0 >nul
    echo ✓ Отключено энергосбережение для адаптера: %%i
)
:: Отключение автоматического отключения дисков
powercfg /setdcvalueindex SCHEME_CURRENT 0012ee47-9041-4b5d-9b77-535fba8b1442 6738e2c4-e8a5-4a42-b16a-e040e769756e 0 >nul
powercfg /setacvalueindex SCHEME_CURRENT 0012ee47-9041-4b5d-9b77-535fba8b1442 6738e2c4-e8a5-4a42-b16a-e040e769756e 0 >nul
echo ✓ Отключено автоматическое отключение дисков
echo.
echo Все энергосберегающие функции отключены!
echo.
pause
goto MAIN_MENU

:MAX_PERF
cls
echo АКТИВАЦИЯ РЕЖИМА МАКСИМАЛЬНОЙ ПРОИЗВОДИТЕЛЬНОСТИ...
echo.
:: Активация плана "Высокая производительность"
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul
echo ✓ Режим максимальной производительности активирован
echo.
:: Дополнительные настройки: повышение производительности процессора
powercfg /setdcvalueindex SCHEME_MIN SUB_PROCESSOR 54533251-82be-4824-96c1-47b60b740d00 100 >nul
powercfg /setacvalueindex SCHEME_MIN SUB_PROCESSOR 54533251-82be-4824-96c1-47b60b740d00 100 >nul
echo ✓ Максимальная производительность процессора
echo.
pause
goto MAIN_MENU

:CALIBRATION
cls
echo КАЛИБРОВКА АККУМУЛЯТОРА
echo.
echo Инструкция:
echo 1. Зарядите ноутбук до 100%.
echo 2. Отключите зарядное устройство.
echo 3. Используйте ноутбук до полного разряда (~5%).
echo 4. Снова зарядите до 100% без перерывов.
echo.
echo Скрипт будет отслеживать процесс.
echo.
choice /c 12 /n /m "Запустить мониторинг? (1-Да, 2-Нет): "
if %errorlevel% equ 2 goto MAIN_MENU

:MONITOR
cls
echo МОНИТОРИНГ КАЛИБРОВКИ [для выхода нажмите Ctrl+C]
echo ================================================
echo.
for /f "tokens=2 delims==" %%a in ('wmic path Win32_Battery get EstimatedChargeRemaining /value ^| find "="') do set percent=%%a
for /f "tokens=2 delims==" %%a in ('wmic path Win32_Battery get BatteryStatus /value ^| find "="') do set state=%%a
echo Текущий заряд: %percent%% 
echo Состояние (BatteryStatus): %state%
echo.
echo ================================================
echo.
timeout /t 5 /nobreak >nul
goto MONITOR

:USAGE_HISTORY
cls
echo ИСТОРИЯ ИСПОЛЬЗОВАНИЯ АККУМУЛЯТОРА:
echo.
echo Последние 5 сессий батареи:
echo.
powercfg /batteryreport /duration 3 | findstr /i /c:"Battery usage" /c:"Duration" /c:"Energy"
echo.
echo Полный отчёт смотрите в файле Battery_Report.html на рабочем столе.
echo.
pause
goto MAIN_MENU

:ROLLBACK
cls
echo ОТКАТ НА ДЕФОЛТНЫЕ НАСТРОЙКИ...
echo.
:: Восстанавливаем дефолтные настройки питания
powercfg /restoredefaultschemes >nul
echo ✓ Дефолтные настройки восстановлены.
echo.
pause
goto MAIN_MENU