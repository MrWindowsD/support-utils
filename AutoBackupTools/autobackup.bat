@echo off
echo Batch File by MrWindows

mkdir "C:\startupbackupsystem"
echo.
xcopy /s "%~dp0.\startup\backupgood.bat" "C:\startupbackupsystem"
xcopy /s "%~dp0.\startup\create_services_backup.vbs" "C:\startupbackupsystem"
xcopy /s "%~dp0.\startup\clearbackupgood.bat" "C:\startupbackupsystem"
echo.

takeown /F "C:\startupbackupsystem" /R

:: ����� �롮� ⨯� ����᪠
echo.
echo.
echo �롥�� ⨯ ����᪠ �����:
echo 1. �� ����祭�� ��⥬� (४�������)
echo 2. ����� N �ᮢ
echo 3. � ��।��񭭮� �६� ������ � ����
set /p choice="������ 1, 2 ��� 3: "

if %choice%==1 (
    goto :onlogon
) else if %choice%==2 (
    goto :hourly
) else if %choice%==3 (
    goto :daily
) else (
    echo �������⨬� �롮�.
    pause
    exit /b
)

:onlogon
:: �������� ����� �� ����祭�� ��⥬�
schtasks /create /tn "BackupTask" /sc onlogon /rl HIGHEST /f /tr C:\startupbackupsystem\backupgood.bat /np
echo.
echo ����� �������஢��� �� ����� �� ����祭�� ��⥬�.
:: �����஢���� ��⮬���᪮� ���⪨ �����
echo.
echo ����ࢭ�� ����� ���� ���浪�� ���� ��������. ���� ����室������ ⠪�� � ��⮬���᪮� ���⪨:
echo 1. ��⮬���᪠� ���⪠ �� �㦭�
echo 2. ������ ������ (४�������)
echo 3. ����� �����
set /p clearinput="������ 1, 2 ��� 3: "

if %clearinput%==1 (
    goto :offclear
) else if %clearinput%==2 (
    goto :weekly
) else if %clearinput%==3 (
    goto :monthly
) else (
    echo �������⨬� �롮�.
    pause
    exit /b
)

:offclear
:: ���⪠ - �⪫�祭�
echo.
echo ��⮬���᪠� ���⪠ - �⪫�祭�. ���� १�ࢭ�� ����� C:\backup\
pause
exit /b

:weekly
:: ������ ������
set /p startTime="�롥� ���� ������ � �ଠ� MON - SUN ��� �������� [MON - SUN...]. � �ਬ��� "FRI" - ������ ��⭨��: "
echo.
schtasks /create /tn "ClearBackupTask" /sc weekly /mo 1 /d %startTime% /st 00:00 /et 23:59 /rl HIGHEST /f /tr C:\startupbackupsystem\clearbackupgood.bat /np
echo.
echo ���⪠ �������஢��� �� ����� %startTime%.
pause
exit /b

:monthly
:: ����� �����
set /p startTime="�롥� ���� �����, 㪠��� �᫮ �� 1 �� 31: "
echo.
schtasks /create /tn "ClearBackupTask" /sc monthly /mo 1 /d %startTime% /st 00:00 /et 23:59 /rl HIGHEST /f /tr C:\startupbackupsystem\clearbackupgood.bat /np
echo.
echo ���⪠ �������஢��� �� ����� %startTime% ���� �����.
pause
exit /b

:hourly
:: ����� �६��� ����᪠
echo.
set /p startTime="�������஢��� �� ����� N �ᮢ (� ��ਮ� �� 1 �� 23 �ᮢ): "
echo.

:: �������� ����� ����� N �ᮢ
schtasks /create /tn "BackupTask" /sc hourly /mo %startTime% /st 00:00 /et 23:59 /k /rl HIGHEST /f /tr C:\startupbackupsystem\backupgood.bat /np
echo.
echo ����ࢭ�� ����஢���� �������஢��� �� ����� %startTime% �ᮢ.
:: �����஢���� ��⮬���᪮� ���⪨ �����
echo.
echo ����ࢭ�� ����� ���� ���浪�� ���� ��������. ���� ����室������ ⠪�� � ��⮬���᪮� ���⪨:
echo 1. ��⮬���᪠� ���⪠ �� �㦭�
echo 2. ������ ������ (४�������)
echo 3. ����� �����
set /p clearinput="������ 1, 2 ��� 3: "

if %clearinput%==1 (
    goto :offclear
) else if %clearinput%==2 (
    goto :weekly
) else if %clearinput%==3 (
    goto :monthly
) else (
    echo �������⨬� �롮�.
    pause
    exit /b
)

:offclear
:: ���⪠ - �⪫�祭�
echo.
echo ��⮬���᪠� ���⪠ - �⪫�祭�. ���� १�ࢭ�� ����� C:\backup\
pause
exit /b

:weekly
:: ������ ������
set /p startTime="�롥� ���� ������ � �ଠ� MON - SUN ��� �������� [MON - SUN...]. � �ਬ��� "FRI" - ������ ��⭨��: "
echo.
schtasks /create /tn "ClearBackupTask" /sc weekly /mo 1 /d %startTime% /st 00:00 /et 23:59 /rl HIGHEST /f /tr C:\startupbackupsystem\clearbackupgood.bat /np
echo.
echo ���⪠ �������஢��� �� ����� %startTime%.
pause
exit /b

:monthly
:: ����� �����
set /p startTime="�롥� ���� �����, 㪠��� �᫮ �� 1 �� 31: "
echo.
schtasks /create /tn "ClearBackupTask" /sc monthly /mo 1 /d %startTime% /st 00:00 /et 23:59 /rl HIGHEST /f /tr C:\startupbackupsystem\clearbackupgood.bat /np
echo.
echo ���⪠ �������஢��� �� ����� %startTime% ���� �����.
pause
exit /b

:daily
:: ����� �६��� ����᪠
set /p startTime="������ �६� ��� ��ࢮ�� ����᪠ (� �ଠ� ��:��): "
echo.
set /p startTime2="������ �६� ��� ��ண� ����᪠ (� �ଠ� ��:��): "
echo.
:: �������� ����� � �����஢騪�
schtasks /create /tn "BackupTask" /sc DAILY /st %startTime% /tr C:\startupbackupsystem\backupgood.bat /rl HIGHEST /f /np
echo.
schtasks /create /tn "BackupTask2" /sc DAILY /st %startTime2% /tr C:\startupbackupsystem\backupgood.bat /rl HIGHEST /f /np
echo.
echo ����ࢭ�� ����஢���� �������஢��� �� %startTime% � %startTime2% ����� ����.
:: �����஢���� ��⮬���᪮� ���⪨ �����
echo.
echo ����ࢭ�� ����� ���� ���浪�� ���� ��������. ���� ����室������ ⠪�� � ��⮬���᪮� ���⪨:
echo 1. ��⮬���᪠� ���⪠ �� �㦭�
echo 2. ������ ������ (४�������)
echo 3. ����� �����
set /p clearinput="������ 1, 2 ��� 3: "

if %clearinput%==1 (
    goto :offclear
) else if %clearinput%==2 (
    goto :weekly
) else if %clearinput%==3 (
    goto :monthly
) else (
    echo �������⨬� �롮�.
    pause
    exit /b
)

:offclear
:: ���⪠ - �⪫�祭�
echo.
echo ��⮬���᪠� ���⪠ - �⪫�祭�. ���� १�ࢭ�� ����� C:\backup\
pause
exit /b

:weekly
:: ������ ������
set /p startTime="�롥� ���� ������ � �ଠ� MON - SUN ��� �������� [MON - SUN...]. � �ਬ��� "FRI" - ������ ��⭨��: "
echo.
schtasks /create /tn "ClearBackupTask" /sc weekly /mo 1 /d %startTime% /st 00:00 /et 23:59 /rl HIGHEST /f /tr C:\startupbackupsystem\clearbackupgood.bat /np
echo.
echo ���⪠ �������஢��� �� ����� %startTime%.
pause
exit /b

:monthly
:: ����� �����
set /p startTime="�롥� ���� �����, 㪠��� �᫮ �� 1 �� 31: "
echo.
schtasks /create /tn "ClearBackupTask" /sc monthly /mo 1 /d %startTime% /st 00:00 /et 23:59 /rl HIGHEST /f /tr C:\startupbackupsystem\clearbackupgood.bat /np
echo.
echo ���⪠ �������஢��� �� ����� %startTime% ���� �����.
pause
exit /b

pause