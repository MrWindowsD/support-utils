@echo off
chcp 866 >nul
setlocal

rem === Параметры ===
set "SRC=H:"
set "DST=C:"
set "USER=Ира"
set "REGDIR=%SRC%\OfficeBackup\RegExports"
set "HKCU_REG=%REGDIR%\HKCU_Office14.reg"
set "HKLM_REG=%REGDIR%\HKLM_OSPP.reg"
rem === /Параметры ===

echo Проверяем, что диск %SRC% доступен...
if not exist "%SRC%\" (
  echo ОШИБКА: %SRC% не найден.
  pause & exit /b 1
)

echo Создаём необходимые папки на %DST%...
md "%DST%\Program Files (x86)\Microsoft Office"    2>nul
md "%DST%\Program Files\Common Files\Microsoft Shared" 2>nul
md "%DST%\ProgramData\Microsoft\Office"             2>nul
md "%DST%\ProgramData\Microsoft\OfficeSoftwareProtectionPlatform" 2>nul
md "%DST%\Windows\Installer"                        2>nul
md "%APPDATA%\Microsoft\Templates"                  2>nul
md "%APPDATA%\Microsoft\UProof"                     2>nul
md "%APPDATA%\Microsoft\Excel\XLSTART"              2>nul
md "%USERPROFILE%\Documents\Custom Office Templates" 2>nul

echo Копируем файлы Office...
robocopy "%SRC%\Program Files (x86)\Microsoft Office"    "%DST%\Program Files (x86)\Microsoft Office"    /MIR /COPYALL /R:2 /W:2
robocopy "%SRC%\Program Files\Common Files\Microsoft Shared" \
        "%DST%\Program Files\Common Files\Microsoft Shared" /MIR /COPYALL /R:2 /W:2
robocopy "%SRC%\ProgramData\Microsoft\Office"             "%DST%\ProgramData\Microsoft\Office"             /MIR /COPYALL /R:2 /W:2
robocopy "%SRC%\ProgramData\Microsoft\OfficeSoftwareProtectionPlatform" \
        "%DST%\ProgramData\Microsoft\OfficeSoftwareProtectionPlatform" /MIR /COPYALL /R:2 /W:2

echo Копируем папку Windows Installer...
robocopy "%SRC%\Windows\Installer" "%DST%\Windows\Installer" /COPYALL /R:2 /W:2

echo Копируем пользовательские настройки (%USER%)...
robocopy "%SRC%\Users\%USER%\AppData\Roaming\Microsoft\Templates" "%APPDATA%\Microsoft\Templates" /MIR /COPYALL /R:2 /W:2
robocopy "%SRC%\Users\%USER%\AppData\Roaming\Microsoft\UProof"    "%APPDATA%\Microsoft\UProof"    /MIR /COPYALL /R:2 /W:2
robocopy "%SRC%\Users\%USER%\AppData\Roaming\Microsoft\Excel\XLSTART" "%APPDATA%\Microsoft\Excel\XLSTART" /MIR /COPYALL /R:2 /W:2
robocopy "%SRC%\Users\%USER%\Documents\Custom Office Templates"    "%USERPROFILE%\Documents\Custom Office Templates" /MIR /COPYALL /R:2 /W:2

echo Импортируем реестр Office...
if exist "%HKCU_REG%" (
  reg import "%HKCU_REG%"
) else (
  echo WARNING: не найден %HKCU_REG%
)
if exist "%HKLM_REG%" (
  reg import "%HKLM_REG%"
) else (
  echo WARNING: не найден %HKLM_REG%
)

echo Настраиваем права доступа...
takeown /F "%DST%\Program Files (x86)\Microsoft Office" /R /D Y >nul
icacls  "%DST%\Program Files (x86)\Microsoft Office" /grant "SYSTEM":F "%USER":F /T /C >nul

echo Резервируем старые файлы лицензии...
for %%F in (
  "%ProgramData%\Microsoft\OfficeSoftwareProtectionPlatform\tokens.dat"
  "%ProgramData%\Microsoft\OfficeSoftwareProtectionPlatform\Cache\cache.dat"
  "%CommonProgramFiles(x86)%\Microsoft Shared\OFFICE14\Office Setup Controller\pkeyconfig-office.xrm-ms"
) do (
  if exist "%%~F" ren "%%~F" "%%~nF.old"
)

echo Введите Retail/Mak ключ Office 2010:
set /p "KEY=Ключ (25 символов): "

echo Применяем ключ и активируем Office...
pushd "%ProgramFiles(x86)%\Microsoft Office\Office14"
cscript //nologo ospp.vbs /inpkey:%KEY%
cscript //nologo ospp.vbs /act
popd

echo Завершено. Система перезагрузится через 10 секунд...
timeout /t 10 /nobreak >nul
shutdown /r /f /t 0

endlocal
