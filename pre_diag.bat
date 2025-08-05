rem от MrWindows
@echo off
@chcp 65001
set LOG_DIR=C:\Logs
set CHKSUM_FILENAME=chkdsk_log.txt
set DUMP_FILENAME=dump_log.txt

if not exist "%LOG_DIR%" (
    mkdir "%LOG_DIR%"
)
echo Made by MrWindows
echo.
echo ===========================
echo Начинаем диагностику ОС...
echo ===========================
echo.
echo Диагностика DISM...
powershell -ExecutionPolicy ByPass -Command "Dism /Online /Cleanup-Image /RestoreHealth"
if errorlevel 1 (
    echo Произошла ошибка во время выполнения DISM.
) else (
    echo DISM завершен успешно!
)
echo.
echo System File Checke...
echo Запуск проверки системных файлов...
sfc /scannow
if errorlevel 1 (
    echo Произошла ошибка при проверке системных файлов.
) else (
    echo Проверка системных файлов завершена успешно!
)
echo.
echo Диагностика системного диска...
echo Запуск chkdsk с флагами /f и /r. Возможно, потребуется перезагрузка для завершения.
chkdsk C: /f /r
if errorlevel 1 (
    echo Произошла ошибка при выполнении команды chkdsk.
) else (
    echo Проверка завершена успешно, все проблемы исправлены!
)

:: Проверка логов событий
echo.
echo Проверка логов событий на наличие ошибок...
wevtutil qe System "/q:*[System[Level=2]]" /f:text > event_log_report.txt
echo Ошибки из журнала событий записаны в event_log_report.txt

echo Создаем дамп для диагностики...
echo ===========================
echo Дамп системной информации > "%LOG_DIR%\%DUMP_FILENAME%"
systeminfo >> "%LOG_DIR%\%DUMP_FILENAME%"
echo Дамп завершен, логи сохранены в "%LOG_DIR%\%DUMP_FILENAME%".
echo ===========================

echo.
echo После выполнения всех проверок необходимо перезагрузить систему. 
pause