# Support Utils v1.0b

**Пакет скриптов для диагностики, автоматизации и быстрого восстановления системы.**  
Создан для задач технической поддержки, начинающих системных администраторов и продвинутых пользователей Windows.

## 🔧 Назначение проекта

- Упрощает диагностику сети и системы средствами CLI;
- Автоматизирует сбор логов, информации об ОС и автозагрузке;
- Позволяет разворачивать подключение по RDP в один клик;
- Включает систему локального резервного копирования конфигураций, пользовательских и системных данных;
- Демонстрирует применение `batch`, `reg`, `vbs` и логирования на практике.

> [!NOTE]
> Проект служит как техническим инструментарием, так и showcase-портфолио CLI-решений: фокус на читаемость, модульность и устойчивость скриптов.

## 🧩 Сценарии использования

- Создание резервной копии ключевых компонентов системы перед экспериментами и настройками;
- Диагностика неполадок с сетью;
- Быстрое развертывание RDP-подключения;
- Сбор и логирование технической информации для тикета;
- Очистка, диагностика, логирование текущего состояния ОС;
- Ознакомление с тем, как устроены системные процессы Windows через командную строку.

## 👨‍💻 Содержание

- [🔧 Назначение проекта](#-назначение-проекта)
- [🧩 Сценарии использования](#-сценарии-использования)
- [🛠️ Используемые технологии](#-используемые-технологии)
- [📦 Статус проекта](#-статус-проекта)
- [⚠️ Ограничения и совместимость](#️-ограничения-и-совместимость)
- [🚀 Установка](#-установка)
- [📄 Скрипты и описание](#-скрипты-и-описание)

## 🛠️ Используемые технологии

| Технология / Инструмент     | Назначение                                                                 |
|-----------------------------|----------------------------------------------------------------------------|
| **Batch (.bat)**            | Автоматизация задач: логирование, копирование, экспорт, диагностика       |
| **VBScript (.vbs)**         | Экспорт конфигураций, взаимодействие с COM-объектами Windows               |
| **Windows CLI**             | Использование встроенных утилит: `ipconfig`, `reg`, `wevtutil`, `tasklist`|
| **REG-файлы**               | Экспорт/импорт параметров реестра                                         |
| **Планировщик задач**       | Запуск задач по расписанию через `schtasks`                         |
| **Журналы Windows (Event Logs)** | Сбор и анализ событий через `wevtutil`, `Event Viewer`                |
| **WinDbg (из Windows SDK)** | Анализ дампов памяти, диагностика системных сбоев                         |
| **WiLogUtl (Windows Kits)** | Расшифровка и анализ `.msi` логов установки, устранение ошибок инсталляции|
| **Git / GitHub**            | Версионирование, публикация и документация проекта    |

## 📦 Статус проекта

> Версия `v1.0b` — базовый стабильный выпуск.

- 🟢 Большинство утилит завершены и протестированы на Windows 10/11.
- 🟡 Некоторые компоненты (например, автоматическая очистка резервных копий) находятся в процессе доработки.
- 🔒 Скрипты, связанные с работой KMS-сервера, исключены из открытого доступа в целях безопасности и во избежание возможного сбоя уже активированных систем.

## ⚠️ Ограничения и совместимость

- Скрипты протестированы на Windows 10/11, версии IoT и Pro.
- Для корректной работы большинства утилит требуются **права администратора**.
- **Windows 7, Windows Server и урезанные сборки** (например, Windows 11 S) не поддерживаются.
- Требуется наличие **PowerShell** (v5.0+), **WMI**, и системных утилит Windows CLI (`ipconfig`, `schtasks`, `wevtutil`, `reg`, `tasklist` и др.).
- Утилиты не проверяют наличие всех служб: при отключении `Remote Registry`, `VSS`, `System Restore`, `WLAN Autoconfig` и других компонентов возможны сбои.
- Некоторые функции (например, отчёты `batteryreport`, `sleepstudy`) доступны **только на устройствах с батареей** и поддержкой Modern Standby.
- В проекте используются **жёстко заданные пути** (`C:\backup`, `C:\Logs`, `%TEMP%`) — при необходимости они должны быть изменены вручную.
- **Антивирусы и политики безопасности** могут блокировать BAT/VBS-файлы — рекомендуется запуск от имени администратора или whitelisting.
- Возможны проблемы с выводом русскоязычного текста в консоли, если используется кодировка, отличная от UTF-8.

> [!IMPORTANT]
> Проект предназначен для ознакомления и обучающих целей. Перед применением в продуктивной среде рекомендуется ревью и настройка в соответствии с политиками безопасности.

## Установка
> [!Note]
> Вы можете загрузить весь проект целиком или клонировать его через Git.

### Вариант 1: Скачивание ZIP-архива
1. Перейдите в репозиторий: [GitHub → Support Utils → Releases](https://github.com/MrWindowsD/support-utils/releases/tag/Utils);
2. Нажмите кнопку на **Support_Utils_v1.0b.rar**;
3. Распакуйте архив в удобное место;
4. Все скрипты готовы к запуску. Рекомендуется запускать их от имени администратора.

### Вариант 2: Клонирование через Git
> Требуется установленный Git. Установить можно через [официальный сайт](https://git-scm.com/download/win) или командой:
```
winget install Git.Git
```

1. Откройте командную строку и выполните:
```bash
git clone https://github.com/MrWindowsD/support-utils.git C:\SupportUtils
```
2. Перейдите в каталог:
```bash
C:\Users\NameUser\SupportUtils
```
3. Запускайте нужные скрипты: `network_diag.bat`, `pre_diag.bat`, `AutoBackupTools\autobackup.bat` и др.

# 📄 Support Utils
Набор BAT‑скриптов для диагностики, логирования и атоматизации некоторых процедур.

## `network_diag.bat` — базовая диагностика сети
**Назначение:**
Выполняет диагностику сетевого соединения, определяет ключевые параметры IP-конфигурации, проверяет доступность внешних хостов, анализирует маршрут и потенциальные потери пакетов. Отчёт сохраняется в файл и открывается автоматически.

**Применение:**
Используется при обращениях с жалобами на потерю интернета, проблемы с DNS или нестабильное соединение. Особенно полезен для предварительной диагностики без доступа к GUI.


**Ключевые команды:**
- `ipconfig /all` — вывод полной конфигурации сетевых интерфейсов (IP, DNS, шлюз)
- `ping 8.8.8.8` — проверка доступности внешнего хоста (Google DNS)
- `tracert ya.ru` — трассировка маршрута до сервера, помогает выявить обрыв
- `netsh winsock reset` — сброс сетевого стека (иногда применяется в расширенной версии)
- `netsh wlan show interfaces` — отображение Wi-Fi-состояния

---

**Синтаксис кода:**

| Синтаксис | Назначение / Пояснение |
|-----------------|-------------------------|
| `@chcp 65001 >nul` | Перевод консоли в UTF-8. Предотвращает кракозябры при выводе русских символов. Если консоль используется в ANSI (chcp 866), путь с кириллицей может сломать скрипт. |
| `powershell -Command "Get-NetAdapter \| Restart-NetAdapter"` | Автоматический перезапуск сетевого адаптера без GUI. Полезно, если адаптер завис. |
| `ping -n 3 -l 65500 %site%` | Отправка "тяжёлых" пакетов. Иногда помогает выявить нестабильное соединение, но может блокироваться маршрутизаторами. |
| `tracert -d -h 10 -w 1000` | Без DNS, ограничение по количеству хопов и таймаутам. Работает быстрее, но может не выявить некоторые узлы. |
| `netsh wlan stop hostednetwork` | Остановка виртуальной Wi-Fi-сети. Применимо для устранения конфликтов при раздаче интернета. |

**Фрагмент кода:**
```bat
@echo off
chcp 65001 >nul
set "log=%TEMP%\network_report.txt"
ipconfig /all >> "%log%"
ping 8.8.8.8 -n 4 >> "%log%"
tracert ya.ru >> "%log%"
start notepad "%log%"
```
<details>
<summary>📄 Показать полный BAT-скрипт</summary>

```bat
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
```

</details>

Особенности:
- Поддержка: Windows 10 и 11;
- Учитывает возможные проблемы с кодировкой, нестабильным адаптером и длинными маршрутами;

> [!WARNING]
> 1. Блокировка ICMP из-за политики фаервола: многие сайты и маршрутизаторы блокируют ICMP‑эхо, поэтому даже работающий сайт может не отвечать на ping/tracert.
> 2. Ограничения на обработку пакетов большого размера: `ping -l 65500` требует прямой поддержки фрагментации, которую могут запрещать маршрутизаторы или DNS CDN. Проблема повышенной задержки без потерь может затушевать реальную суть.
> 3. Трэйсерут не всегда показывает полный маршрут: он использует TTL, но если промежуточный маршрутизатор не отвечает ICMP «Time exceeded», трассировка на этом месте обрывается.
> 4. Тайм-ауты и единичные результаты: ответа может не быть из-за сетевой перегруженности или превышения лимита — это не всегда означает обрыв связи.

## `pre_diag.bat` — базовая диагностика ОС Windows

**Назначение:**
Автоматизирует ключевые проверки целостности и стабильности Windows: выполняет восстановление компонентов через DISM, проверку системных файлов (`sfc`) и диагностику системного диска (`chkdsk`). Результаты отображаются в окне консоли и сохраняются в папку `C:\Logs`.

**Применение:**
Рекомендуется для устранения системных сбоев, предварительной диагностики перед тикетом в поддержку, подготовки ПК к переносу или массовому обслуживанию. Особенно актуально при возникновении BDOS, ошибок служб, и нестабильности системы.

**Ключевые команды:**
* `DISM /Online /Cleanup-Image /RestoreHealth` — восстановление образа Windows;
* `sfc /scannow` — сканирование и автоматическое восстановление повреждённых системных файлов;
* `chkdsk C: /f /r` — диагностика и исправление ошибок на системном диске;
* `mkdir`, `set`, `if errorlevel` — создание логов и контроль ошибок.

---

**Синтаксис кода:**

| Синтаксис                                         | Назначение / Пояснение                                                       |
| ------------------------------------------------- | ---------------------------------------------------------------------------- |
| `@chcp 65001`                                     | Перевод консоли в UTF-8. Исключает искажение символов в русскоязычной среде. |
| `if not exist "%LOG_DIR%" ( mkdir "%LOG_DIR%" )`  | Автоматическое создание каталога для логов                                   |
| `powershell -ExecutionPolicy ByPass -Command ...` | Обход ограничений PowerShell-политики, запуск DISM                           |
| `wevtutil qe System ... Level=2`                  | Извлечение ошибок уровня *Critical/Error*                                    |
| `systeminfo >> лог`                               | Формирование дампа ОС в текстовом виде                                       |
| `if errorlevel (...) else (...)`                  | Контроль выполнения каждого этапа с fallback-поведенческой логикой           |

**Фрагмент кода:**

```bat
@echo off
@chcp 65001
set LOG_DIR=C:\Logs
set CHKSUM_FILENAME=chkdsk_log.txt
set DUMP_FILENAME=dump_log.txt

if not exist "%LOG_DIR%" (
    mkdir "%LOG_DIR%"
)

:: Восстановление системных компонентов
powershell -ExecutionPolicy ByPass -Command "Dism /Online /Cleanup-Image /RestoreHealth"

:: Проверка системных файлов
sfc /scannow

:: Диагностика жёсткого диска
chkdsk C: /f /r

:: Парсинг системного журнала на ошибки
wevtutil qe System "/q:*[System[Level=2]]" /f:text > event_log_report.txt

:: Создание дампа системной информации
systeminfo >> "%LOG_DIR%\%DUMP_FILENAME%"

```

<details>
<summary>📄 Показать полный BAT-скрипт</summary>

```bat
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
```

</details>

Особенности:

- Поддержка: Windows 10 и Windows 11;
- Использует встроенные средства ОС — не требует внешних утилит;
- Все логи сохраняются в папку C:\Logs (создаётся автоматически);
- Оповещает пользователя о результатах каждого этапа;
- После выполнения всех проверок запрашивает перезагрузку.

**Логирование:**

1. **Файлы:**
    - `%LOG_DIR%\%DUMP_FILENAME%` — системный дамп;
    - `event_log_report.txt` — выгрузка системных ошибок.
2. **Содержимое логов:**
    - `systeminfo`: сборка ОС, архитектура, память, аптайм, установленные обновления;
    - `wevtutil`: ошибки ядра, драйверов, служб.
3. **Обработка ошибок:**
    - Используется `if errorlevel` для контроля и отображения завершения каждого блока (`DISM`, `sfc`, `chkdsk`)
  
### Анализ логов и дампов

#### 1. Анализ системных логов (через `event_log_report.txt`)

Логи собираются через:
```bat
wevtutil qe System "/q:*[System[Level=2]]" /f:text > event_log_report.txt
````
<img width="1777" height="938" alt="event_log" src="https://github.com/user-attachments/assets/4fc8c117-7f26-481e-aac5-d4d129247ec2" />

Это позволяет отфильтровать ошибки уровня `Critical` и `Error` из системного журнала Windows.

**Основные принципы анализа:**
* Обратить внимание на **Event ID** и **Source** — они указывают на тип сбоя.
* Смотреть на **время события** и **повторяемость** — помогает отследить закономерность.
* Сопоставлять ошибки с действиями пользователя или моментами перезагрузки.

**Пример лога (фрагмент):**

```text
Event[2128]:
  Log Name: System
  Source: Disk
  Date: 2024-08-01T13:05:12.1230000Z
  Event ID: 7
  Task: None
  Level: Error
  Opcode: Info
  Message: The device, \Device\Harddisk0\DR0, has a bad block.
```

* **Source: Disk**, **Event ID: 7** — ошибка жёсткого диска, возможен сбой чтения.
* Нужно проверить SMART-статус и выполнить полную проверку `chkdsk`.

Также скрипт создаёт дополнительный дамп `dump_log` для быстрой первичной диагностики.

<details>
<summary>🔍 Пример dump_log</summary>

```log
Дамп системной информации 

Host Name:                ***
OS Name:                   Майкрософт Windows 11 Pro
OS Version:                10.0.22631 N/A Build 22631
OS Manufacturer:           Microsoft Corporation
OS Configuration:          Standalone Workstation
OS Build Type:             Multiprocessor Free
Registered Owner:          ***
Registered Organization:   
Product ID:                ***
Original Install Date:     18.02.2024, 23:19:51
System Boot Time:          05.08.2025, 15:10:44
System Manufacturer:       ASUS
System Model:              All Series
System Type:               x64-based PC
Processor(s):              1 Processor(s) Installed.
                           [01]: Intel64 Family 6 Model 63 Stepping 2 GenuineIntel ~2304 Mhz
BIOS Version:              American Megatrends Inc. 2101, 10.07.2019
Windows Directory:         C:\Windows
System Directory:          C:\Windows\system32
Boot Device:               \Device\HarddiskVolume1
System Locale:             ru;Russian
Input Locale:              ru;Russian
Time Zone:                 (UTC+03:00) Moscow, St. Petersburg
Total Physical Memory:     32 682 MB
Available Physical Memory: 19 761 MB
Virtual Memory: Max Size:  70 570 MB
Virtual Memory: Available: 50 418 MB
Virtual Memory: In Use:    20 152 MB
Page File Location(s):     C:\pagefile.sys
                           H:\pagefile.sys
Domain:                    WORKGROUP
Logon Server:              \\***
Hotfix(s):                 6 Hotfix(s) Installed.
                           [01]: KB5056580
                           [02]: KB5027397
                           [03]: KB5033055
                           [04]: KB5062552
                           [05]: KB5058546
                           [06]: KB5063707
Network Card(s):           6 NIC(s) Installed.
                           [01]: Intel(R) Ethernet Connection (2) I218-V
                                 Connection Name: Ethernet
                                 DHCP Enabled:    Yes
                                 DHCP Server:     192.168.50.1
                                 IP address(es)
                                 [01]: 111.111.11.1
                                 [02]: ffff::ffff:ffff:ffff:ffff
                           [02]: TAP-Windows Adapter V9
                                 Connection Name: Ethernet 2
                                 Status:          Media disconnected
                           [03]: OpenVPN Data Channel Offload
                                 Connection Name: OpenVPN Data Channel Offload
                                 Status:          Media disconnected
                           [04]: TAP-Windows Adapter V9
                                 Connection Name: Ethernet 4
                                 Status:          Media disconnected
                           [05]: VMware Virtual Ethernet Adapter for VMnet1
                                 Connection Name: VMware Network Adapter VMnet1
                                 DHCP Enabled:    Yes
                                 DHCP Server:     192.168.126.254
                                 IP address(es)
                                 [01]: 111.111.11.1
                                 [02]: ffff::ffff:ffff:ffff:ffff
                           [06]: VMware Virtual Ethernet Adapter for VMnet8
                                 Connection Name: VMware Network Adapter VMnet8
                                 DHCP Enabled:    Yes
                                 DHCP Server:     192.168.174.254
                                 IP address(es)
                                 [01]: 111.111.11.1
                                 [02]: ffff::ffff:ffff:ffff:ffff
Hyper-V Requirements:      VM Monitor Mode Extensions: Yes
                           Virtualization Enabled In Firmware: Yes
                           Second Level Address Translation: Yes
                           Data Execution Prevention Available: Yes

```

</details>

#### 2. Анализ дампов через `WinDbg`

**Что такое WinDbg?**
**WinDbg** — это отладчик от Microsoft, входящий в состав Windows SDK. Используется для анализа дампов памяти, BSOD, сбоев ядра и драйверов.

<img width="1719" height="869" alt="DbgX Shell_LvxEwYdZSG" src="https://github.com/user-attachments/assets/3a45ba23-62fb-4242-8980-e42e07c83e35" />

**Установка:**

1. Скачайте Windows SDK с [официального сайта](https://developer.microsoft.com/en-us/windows/downloads/sdk-archive/);
2. При установке **отметьте только "Debugging Tools for Windows"** (WinDbg);
3. После чего можно загрузить ранее созданный дамп: `File → Open Crash Dump → выберите .dmp файл`.

**Откуда берётся дамп?**
Файл с расширением `.dmp` создаётся **автоматически**, когда система сталкивается с критической ошибкой, и включена настройка сохранения дампа:

- Полный дамп: `C:\Windows\MEMORY.DMP`
- Минидампы: `%SystemRoot%\Minidump\*.dmp`

Если BSOD не сохраняет дампы:
- Откройте **Панель управления → Система → Дополнительные параметры системы → Загрузка и восстановление**
- Убедитесь, что включено "Запись отладочной информации" → **Малый дамп памяти (256 КБ)**

**Базовые команды:**

- ```!analyze -v``` — основной отчёт по сбою;
- ```lm``` — список загруженных модулей (драйверов);
- ```kv``` — стек вызовов.

**Пример анализа дампа:**

```text
BugCheck 1A, {41792, fffff68000012340, 8000000000000000, 0}

Probably caused by : ntkrnlmp.exe ( nt! ?? ::FNODOBFM::`string'+3618d )

PROCESS_NAME: chrome.exe
```

* **BugCheck 1A** — ошибка управления памятью (MEMORY\_MANAGEMENT);
* **chrome.exe** — активный процесс, но не обязательно виновник;
* **ntkrnlmp.exe** — ядро системы, вероятно, ошибка в драйвере/оборудовании.

> \[!NOTE]
> По `BugCheck` и `Event ID` можно искать расшифровки в базе Microsoft:
> [https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/bug-check-code-reference2](https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/bug-check-code-reference2)

<details>
<summary>🔍 Пример полного анализа</summary>

```log
KEY_VALUES_STRING: 1

    Key  : AV.Dereference
    Value: NullPtr

    Key  : AV.Fault
    Value: Read

    Key  : Analysis.CPU.mSec
    Value: 578

    Key  : Analysis.Elapsed.mSec
    Value: 68368

    Key  : Analysis.IO.Other.Mb
    Value: 64

    Key  : Analysis.IO.Read.Mb
    Value: 1

    Key  : Analysis.IO.Write.Mb
    Value: 86

    Key  : Analysis.Init.CPU.mSec
    Value: 46

    Key  : Analysis.Init.Elapsed.mSec
    Value: 27288

    Key  : Analysis.Memory.CommitPeak.Mb
    Value: 135

    Key  : Analysis.Version.DbgEng
    Value: 10.0.27725.1000

    Key  : Analysis.Version.Description
    Value: 10.2408.27.01 amd64fre

    Key  : Analysis.Version.Ext
    Value: 1.2408.27.1

    Key  : Failure.Bucket
    Value: NULL_POINTER_READ_c0000005_acad.exe!Unknown

    Key  : Failure.Hash
    Value: {33e1f895-55a8-b4bc-c76f-1263f4f312ab}

    Key  : Timeline.Process.Start.DeltaSec
    Value: 4

    Key  : WER.Process.Version
    Value: 30.1.51.0


FILE_IN_CAB:  acadminidump.dmp

CONTEXT:  (.ecxr)
rax=0000000000000000 rbx=00007ff7f8e39150 rcx=0000000000000000
rdx=00007ff7f8e39180 rsi=0000000000000000 rdi=00007ff7f8e35930
rip=00007ff7f89f9c85 rsp=000000e40f9ff600 rbp=000000e40f9ff699
 r8=000002c1172c15c0  r9=0000000000000001 r10=0000000000000003
r11=000000e40f9ff4f0 r12=00007ff7f8e35930 r13=0000000000000000
r14=0000000000000000 r15=0000000000000001
iopl=0         nv up ei pl nz na po nc
cs=0033  ss=002b  ds=002b  es=002b  fs=0053  gs=002b             efl=00010206
acad!AcApDocWindowManager::newIterator+0x135:
00007ff7`f89f9c85 4c8b00          mov     r8,qword ptr [rax] ds:00000000`00000000=????????????????
Resetting default scope

EXCEPTION_RECORD:  (.exr -1)
ExceptionAddress: 00007ff7f89f9c85 (acad!AcApDocWindowManager::newIterator+0x0000000000000135)
   ExceptionCode: c0000005 (Access violation)
  ExceptionFlags: 00000000
NumberParameters: 2
   Parameter[0]: 0000000000000000
   Parameter[1]: 0000000000000000
Attempt to read from address 0000000000000000

PROCESS_NAME:  acad.exe

READ_ADDRESS:  0000000000000000 

ERROR_CODE: (NTSTATUS) 0xc0000005 -                      0x%p                               0x%p.                      %s.

EXCEPTION_CODE_STR:  c0000005

EXCEPTION_PARAMETER1:  0000000000000000

EXCEPTION_PARAMETER2:  0000000000000000

STACK_TEXT:  
000000e4`0f9ff600 00007ff7`f89e053b     : 00000000`00000000 00007ff7`f8cc1190 000000e4`0f9ff699 00007ff7`f8e35930 : acad!AcApDocWindowManager::newIterator+0x135
000000e4`0f9ff630 00007ffb`d2c52bf0     : 00000000`00000001 00000000`00000001 00000000`00000000 000002c1`173c7e30 : acad!getAcLicenseSettings+0x6feb
000000e4`0f9ff700 00007ff7`f8a09602     : 00000000`00000001 00000000`00000000 00000000`00000000 00000000`00000000 : mfc140u!AfxWinMain+0xc0
000000e4`0f9ff740 00007ffc`10ba259d     : 00000000`00000000 00000000`00000000 00000000`00000000 00000000`00000000 : acad!AcMenuIconLibrary::operator=+0xaa32
000000e4`0f9ff780 00007ffc`1190af38     : 00000000`00000000 00000000`00000000 00000000`00000000 00000000`00000000 : kernel32!BaseThreadInitThunk+0x1d
000000e4`0f9ff7b0 00000000`00000000     : 00000000`00000000 00000000`00000000 00000000`00000000 00000000`00000000 : ntdll!RtlUserThreadStart+0x28


STACK_COMMAND:  ~0s; .ecxr ; kb

SYMBOL_NAME:  acad+135

MODULE_NAME: acad

IMAGE_NAME:  acad.exe

FAILURE_BUCKET_ID:  NULL_POINTER_READ_c0000005_acad.exe!Unknown

OSPLATFORM_TYPE:  x64

OSNAME:  Windows 10

IMAGE_VERSION:  30.1.51.0

FAILURE_ID_HASH:  {33e1f895-55a8-b4bc-c76f-1263f4f312ab}

Followup:     MachineOwner
```

<img width="1920" height="1009" alt="DbgX Shell_IFxsxONTN7" src="https://github.com/user-attachments/assets/19c7444a-0ca1-4990-82cb-7e52fca59fa2" />

</details>

---

> \[!WARNING]
> 1. `chkdsk` — потребует перезагрузку системы;
> 2. `DISM` требует активного подключения к интернету или локального источника для восстановления;
> 3. `sfc` может ничего не показать в консоли, если ошибок не найдено — нужно проверить `CBS.log`;

## `office_profile_export.bat` — демонстрация автоматизации миграции пользовательского окружения Office

**Назначение:**
Сценарий демонстрирует подход к автоматизированной миграции среды пользователя и ключевых компонентов Microsoft Office при наличии локального доступа к исходному диску. Основное внимание уделено воспроизводимой структуре, параметризации и копированию реестра — без применения стороннего ПО.

**Применение:**
Скрипт разработан как **пример практической автоматизации**, применимый в следующих кейсах:

* Автоматизация переноса пользовательского окружения;
* Формирование шаблона для частичной миграции при смене ПК;
* Миграция реестровых и файловых компонентов Microsoft Office (или других компонентов системы) для повторного использования или восстановления. 

Может быть полезен при восстановлении доступа к данным после физического извлечения диска, либо при подготовке кастомного миграционного сценария вручную.

**Ключевые команды:**

* `robocopy` — автоматическое рекурсивное копирование системных и пользовательских папок Office;
* `reg export` — экспорт настроек и активации из веток `HKCU` и `HKLM`;
* `md` — ручное создание требуемых путей (`AppData`, `ProgramData`, `Templates`);
* `set` — параметризация путей и имени пользователя для переноса;
* `if not exist (...) exit /b` — валидация доступности источника (например, `H:\` — подключённый диск).

---

**Синтаксис кода:**

| Синтаксис                                      | Назначение / Пояснение                                                                                                                                                          |
| ---------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `@chcp 866 >nul`                               | Установка OEM-кодировки (CP866) для корректной работы с кириллическими путями и именами файлов. Без неё возможны ошибки при доступе к директориям `C:\Пользователи` и подобным. |
| `if not exist "%SRC%\" (...) exit /b`          | Защита от попытки миграции при отсутствии источника данных (например, отключён диск).                                                                                           |
| `robocopy "%SRC%\..." "%DST%\..." /E /COPYALL` | Рекурсивное копирование с сохранением всех атрибутов и метаданных файлов.                                                                                                       |
| `reg export "..." "%REGDIR%\..." /y`           | Экспорт ключей реестра, в том числе OSPP (Office Software Protection Platform).                                                                                                 |
| `md "%APPDATA%\Microsoft\..." 2>nul`           | Создание вложенных пользовательских папок без генерации ошибок при повторном запуске.                                                                                           |

---

**Фрагмент кода:**

```bat
set "SRC=H:"
set "DST=C:"
set "USER=Ира"

robocopy "%SRC%\Program Files (x86)\Microsoft Office" "%DST%\Program Files (x86)\Microsoft Office" /E
reg export "HKCU\Software\Microsoft\Office\14.0" "%REGDIR%\HKCU_Office14.reg" /y
```

<details>
<summary>📄 Показать полный BAT-скрипт</summary>

```bat
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

```
</details>

---

**Особенности:**

* Скрипт не предназначен для production-массового применения, а служит как демонстрация навыков миграции через CLI;
* Использует чистый `batch` без внешних зависимостей;
* Подходит для обучения, тестирования и разработки кастомных утилит переноса;
* Структура легко адаптируется под другие версии Office и пользовательские директории;
* Чёткая логика: проверка доступа, создание папок, экспорт реестра, копирование.

---

> \[!WARNING]
>
> 1. Этот скрипт **не является полной системой миграции Office** — он показывает основные принципы копирования структуры и настроек;
> 2. Активация Office не переносится между системами таким способом — используется как демонстрация реестрового экспорта;
> 3. Некоторые пути жёстко зашиты (`Program Files`, `%APPDATA%`) — актуально при ручной проверке или подготовке к адаптации;
> 4. Скрипт требует локального доступа к исходному носителю (например, через подключение диска H:).

## `AutoBackupTools` — CLI-пакет автоматического резервного копирования ключевых пользовательских и системных данных

**Назначение:**
CLI-утилита, демонстрирующая автоматизацию резервного копирования пользовательских и системных данных с использованием стандартных средств Windows (**batch** и **VBS**). Пакет включает средства создания, очистки и планирования бэкапов, а также работу с планировщиком задач (**Task Scheduler**). Скрипт подчёркивает важность превентивной защиты от потери данных и может использоваться как шаблон для адаптации, а также при обучении резервирования.

**Применение:**
Используется в следующих сценариях:

* CLI-автоматизации резервного копирования;
* Быстрое развёртывание резервного механизма при локальной работе с уязвимыми системами;
* Тестирование создания фоновых задач через `Task Scheduler`;
* Частичное восстановление после пользовательских ошибок или отказа Windows;
* Формирование базового restore-процесса без сторонних утилит.

**Состав пакета и описание скриптов:**

| Файл                         | Назначение                                                                                                                                         |
| ---------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| `autobackup.bat`             | Главный скрипт: инициирует резервное копирование, создаёт задачу автозапуска через `create_services_backup.vbs`.                                   |
| `backupgood.bat`             | Функциональный скрипт копирования: рекурсивно сохраняет пользовательские файлы, конфигурации, папки из `%APPDATA%` и рабочего стола в `C:\backup`. |
| `create_services_backup.vbs` | Через COM-интерфейс создаёт задачу в планировщике Windows (`Task Scheduler`) для периодического запуска `autobackup.bat`.                          |
| `clearbackupgood.bat`        | Полностью очищает папку резервных копий. **Находится в доработке из-за нестабильности выполнения задачи в системе**. |
| `delet autobackup.bat`       | Удаляет созданную задачу. |

> \[!NOTE]
> Основной функционал работает стабильно: создание, копирование, автоматизация.
> В стадии доработки:
>   * `clearbackupgood.bat`: неполная поддержка сценария выполнения задачи;
>   * возможность расширения механизма версионирования и создания архивов.

### `autobackup.bat` — управляющий сценарий запуска резервного копирования и планирования задач

Создаёт локальную копию инфраструктуры резервного копирования (`*.bat`, `*.vbs`) в системную директорию `C:\startupbackupsystem`, запускает основной сценарий резервного копирования, а также инициирует создание задачи в планировщике Windows с выбранным пользователем расписанием (`onlogon`, `hourly`, `daily`, `weekly`, `monthly`).

---

**Ключевые команды:**

* `xcopy /s` — копирование вспомогательных скриптов в `C:\startupbackupsystem`;
* `takeown /F /R` — получение прав на системную директорию;
* `schtasks /create` — создание задачи в планировщике с параметрами запуска;
* `set /p`, `goto` — выбор режима выполнения (onlogon, hourly, daily и др.).

---

**Синтаксис кода:**

| Синтаксис                                      | Назначение / Пояснение                                                                        |
| ---------------------------------------------- | --------------------------------------------------------------------------------------------- |
| `xcopy /s "%~dp0\startup\..." "C:\startup..."` | Копирует вспомогательные скрипты из подкаталога рядом с `autobackup.bat` в рабочую директорию |
| `schtasks /create /tn "BackupTask"`            | Создаёт задачу в Task Scheduler на запуск `backupgood.bat`                                    |
| `schtasks /create /tn "ClearBackupTask"`       | Создаёт задачу для запуска очистки `clearbackupgood.bat` по расписанию                        |
| `takeown /F ... /R`                            | Передаёт права на директорию                        |
| `set /p choice=`                               | Запрашивает у пользователя выбор режима запуска и очистки                                     |

---

**Фрагмент кода:**

```bat
xcopy /s "%~dp0\startup\backupgood.bat" "C:\startupbackupsystem"
schtasks /create /tn "BackupTask" /sc onlogon /rl HIGHEST /f /tr C:\startupbackupsystem\backupgood.bat /np
```

<details>
<summary>📄 Показать полный BAT-скрипт</summary>

```bat
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

```
</details>

<details>
<summary>🔍 .xml код созданной задачи</summary>

```xml
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Date>2024-11-25T15:26:52</Date>
    <Author>***\***</Author>
    <URI>\BackupTask</URI>
  </RegistrationInfo>
  <Triggers>
    <LogonTrigger>
      <StartBoundary>2024-11-25T15:26:00</StartBoundary>
      <Enabled>true</Enabled>
    </LogonTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <UserId>S-1-5-21-1290947932-2171505560-238677863-1001</UserId>
      <LogonType>S4U</LogonType>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>true</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>true</StopIfGoingOnBatteries>
    <AllowHardTerminate>true</AllowHardTerminate>
    <StartWhenAvailable>false</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <Duration>PT10M</Duration>
      <WaitTimeout>PT1H</WaitTimeout>
      <StopOnIdleEnd>true</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>false</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>PT72H</ExecutionTimeLimit>
    <Priority>7</Priority>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>C:\startupbackupsystem\backupgood.bat</Command>
    </Exec>
  </Actions>
</Task>
```

</details>

---

**Особенности:**

* Позволяет выбрать режим запуска: при входе, ежечасно, ежедневно, еженедельно, ежемесячно;
* Обеспечивает автоматический запуск копирования и очистки без участия пользователя;
* Все действия выполняются средствами Windows CLI, без внешних зависимостей.

💻 `delet autobackup.bat` — используется для удаления задачи из планировщика и очистки остаточных файлов.

```bat
@echo off
echo Batch File By MrWindows
echo.

schtasks /delete /tn "BackupTask" /f
schtasks /delete /tn "BackupTask2" /f
schtasks /delete /tn "ClearBackupTask" /f

@RD /s /q "C:\startupbackupsystem"
echo.
echo bat файл успешно удален!
pause
```

---

### `backupgood.bat` — скрипт резервного копирования

Создаёт резервные копии системного реестра и конфигурации служб. Использует стандартные средства Windows и структуру каталогов `C:\backup`.

---

**Ключевые команды:**

* `reg export` — экспорт ветки HKLM в `.reg`-файл;
* `cscript create_services_backup.vbs` — создание дампа служб Windows;
* `net start`, `sc start` — принудительный запуск необходимых служб (`VSS`, `Remote Registry`, `Windows Backup`);
* `mkdir` — создание целевых директорий под архив текущей даты;
* `set`, `%date%` — динамическое формирование путей на основе даты выполнения.

---

**Синтаксис кода:**

| Синтаксис                                             | Назначение / Пояснение                                   |
| ----------------------------------------------------- | -------------------------------------------------------- |
| `sc query VSS \| findstr "RUNNING" \|\| sc start VSS` | Запуск службы теневого копирования, если не запущена     |
| `reg export HKLM "%regBackupFile%"`                   | Экспорт системного реестра                               |
| `cscript create_services_backup.vbs output.reg`       | Сохранение конфигурации служб через WMI                  |
| `set "dateStamp=%date:~0,2%.%date:~3,2%.%date:~6,4%"` | Формирование имени папки резервной копии по дате запуска |

---

**Фрагмент кода:**

```bat
set "backupDir=C:\backup\registry"
set "dateStamp=%date:~0,2%.%date:~3,2%.%date:~6,4%"
set "backupPath=%backupDir%\%dateStamp%"
mkdir "%backupPath%"
reg export HKLM "%backupPath%\system_registry_backup.reg"
```

<details>
<summary>📄 Показать полный BAT-скрипт</summary>

```bat
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

```
</details>

---

**Особенности:**

* Автоматически запускает все необходимые службы, включая `Volume Shadow Copy`, `Remote Registry`, `System Restore Service`;
* Создаёт структуру резервных копий с разбивкой по дате (`C:\backup\registry\DD.MM.YYYY`);
* Использует только встроенные средства Windows, без стороннего ПО;
* Запускается как вручную, так и автоматически из задач, созданных `autobackup.bat`;
* Выполняется "тихо", то есть в фоне.

💻 `clearbackupgood.bat` — данный BAT-скрипт выполняет очистку копий с заданными параметрами планировщика.

```bat
:: Очистка резервных копий
@RD /s /q "C:\backup\"
:: Запуск резервного копирования
schtasks /run /tn "BackupTask"
echo Done
```

> \[!NOTE]
> Рекомендуется запускать в ручную.


### `create_services_backup.vbs` — экспорт конфигурации служб через WMI

Сохраняет параметры автозапуска всех служб Windows в `.reg`-файл на основе их текущего состояния через WMI. Используется как часть процедуры резервного копирования.

**Что такое `.vbs`?**

Visual Basic Script (VBS) — встроимый сценарный язык Windows, основанный на COM/WSH. Позволяет напрямую обращаться к `WMI` (Windows Management Instrumentation) для получения структурированных данных о состоянии ОС — в том числе о службах.

В отличие от `batch`, VBS:

* Даёт доступ к `Win32_Service` через `WMI`;
* Позволяет работать со сложными объектами (службы, процессы, реестр) в циклах;
* Умеет динамически формировать `.reg`-файл без внешних зависимостей.

Это решение использовано потому, что средствами `cmd` невозможно извлечь полный список служб с их режимами запуска в машиночитаемом виде.

---

**Ключевые команды:**

* `GetObject("winmgmts:...")` — подключение к пространству `WMI`;
* `Win32_Service` — перечисление всех зарегистрированных служб;
* `StartMode → DWORD` — сопоставление режима автозапуска служб с форматом, принятым в реестре;
* `OpenTextFile(..., 2, True)` — запись в файл с перезаписью и созданием.

---

**Синтаксис кода:**

| Синтаксис                                  | Назначение / Пояснение                                       |
| ------------------------------------------ | ------------------------------------------------------------ |
| `GetObject("winmgmts:\\\\.\\root\\cimv2")` | Получение доступа к WMI на локальной машине                  |
| `ExecQuery("Select * from Win32_Service")` | Извлечение объектов служб                                    |
| `objService.StartMode`                     | Получение типа запуска (`auto`, `manual`, `disabled` и т.д.) |
| `WriteLine "[HKEY_LOCAL_MACHINE\...]"`     | Формирование блока `.reg`-файла вручную                      |

---

**Фрагмент кода:**

```vbscript
b.WriteLine "[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\" & objService.Name & "]"
Select Case LCase(objService.StartMode)
    Case "auto":    b.WriteLine "Start=dword:00000002"
    Case "manual":  b.WriteLine "Start=dword:00000003"
    Case "disabled":b.WriteLine "Start=dword:00000004"
End Select
```

<details>
<summary>📄 Показать полный VBS-скрипт</summary>

```vbscript
Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

Dim strBackupFile, b, strComputer, objWMIService, colListOfServices, objService
Dim iSvcCount, sShortName

strComputer = "."
iSvcCount = 0

Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colListOfServices = objWMIService.ExecQuery("Select * from Win32_Service")

' Получаем путь к файлу резервной копии служб из параметров скрипта
Set args = WScript.Arguments
If args.Count > 0 Then
    strBackupFile = args(0)
Else
    WScript.Echo "Путь к файлу резервной копии служб не указан."
    WScript.Quit 1
End If

Set b = objFSO.OpenTextFile(strBackupFile, 2, True)
b.WriteLine "Windows Registry Editor Version 5.00"

For Each objService In colListOfServices
    iSvcCount = iSvcCount + 1
    b.WriteLine "[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\" & objService.Name & "]"
    sShortName = LCase(objService.StartMode)
    Select Case sShortName
        Case "boot"
            b.WriteLine "Start=dword:00000000"
        Case "system"
            b.WriteLine "Start=dword:00000001"
        Case "auto"
            b.WriteLine "Start=dword:00000002"
        Case "manual"
            b.WriteLine "Start=dword:00000003"
        Case "disabled"
            b.WriteLine "Start=dword:00000004"
        Case Else
            ' Обработка других случаев, если необходимо
    End Select
    b.WriteBlankLines 1
Next

b.Close

Set objFSO = Nothing

```
</details>

---

**Особенности:**

* Работает на всех версиях Windows с поддержкой WMI и WSH;
* Может быть переиспользован как самостоятельный инструмент для инвентаризации служб;
* Совместим с форматом `regedit` — полученный `.reg` можно применить на другой машине или целевой для восстановления режима запуска служб.

---

`AutoBackupTools` демонстрирует подход к построению автономного CLI-инструмента для резервного копирования без использования стороннего ПО.
Ключевые аспекты проекта:

* Разделение логики на независимые сценарии с возможностью доработки;
* Работа с `Task Scheduler`, `WMI`, `VSS`, `Registry` — в реальных административных задачах;
* Возможность адаптации под задачи восстановления, аудита и защиты пользовательских конфигураций;
* Реализация полного цикла: от копирования до автоматической очистки, с гибкой настройкой расписаний.

## `BatteryMaster.bat` — диагностика и оптимизация аккумулятора

**Назначение:**
Инструмент для обслуживания и восстановления программной части управления питанием. Выполняет диагностику состояния аккумулятора, создаёт энергетические отчёты, восстанавливает схемы питания, предоставляет ручной механизм калибровки батареи.

**Применение:**
Используется при падении ёмкости аккумулятора, сбоях в отображении заряда, нарушении режимов сна/гибернации, после замены батареи или при длительной работе устройства в сети.

---

**Ключевые команды:**

* `powercfg /batteryreport` — отчёт о циклах, проектной и фактической ёмкости;
* `powercfg /energy` — выявление энергопаразитных процессов и конфликтов драйверов;
* `powercfg /sleepstudy` — анализ переходов в спящий режим (для систем с Modern Standby);
* `powercfg /restoredefaultschemes` — сброс всех схем до заводских значений;
* `sfc /scannow`, `dism /Online /Cleanup-Image /RestoreHealth` — устранение проблем с управлением питанием;
* `shutdown /h` — принудительный переход в гибернацию, используется для ручной калибровки;
* `net session` — проверка запуска от имени администратора;
* `ver | find` — определение версии ОС для адаптации интерфейса.

---

**Синтаксис кода:**

| Синтаксис                               | Назначение / Пояснение                                                        |
| --------------------------------------- | ----------------------------------------------------------------------------- |
| `powercfg /batteryreport /output "..."` | Генерация HTML-отчёта об аккумуляторе в указанный путь                        |
| `powercfg /sleepstudy /output "..."`    | Актуально только для систем с поддержкой Modern Standby (Windows 10/11)       |
| `shutdown /h`                           | Используется для глубокой разрядки аккумулятора при калибровке                |
| `setlocal enabledelayedexpansion`       | Обеспечивает работу переменных внутри условных блоков и циклов                |

---

**Фрагмент кода:**

```bat
powercfg /batteryreport /output "%USERPROFILE%\Desktop\battery_report.html"
powercfg /energy /output "%USERPROFILE%\Desktop\energy_report.html"
powercfg /sleepstudy /output "%USERPROFILE%\Desktop\sleepstudy_report.html"
```

<details>
<summary>📄 Показать полный BAT-скрипт</summary>

```bat
@echo off
echo Batch File by MrWindows
chcp 65001 > nul

setlocal enabledelayedexpansion

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

```
</details>


---

**Логирование:**

1. **Файлы отчётов:**

   * `battery_report.html` — полный отчёт об аккумуляторе (проектная ёмкость, износ, история циклов);
   * `energy_report.html` — список проблем в управлении питанием;
   * `sleepstudy_report.html` — отчёт о переходах в режим сна (если поддерживается).
     Все отчёты сохраняются на рабочий стол пользователя (`%USERPROFILE%\Desktop`).

<img width="1280" height="638" alt="image" src="https://github.com/user-attachments/assets/c582b4af-6c0a-4f30-8106-3f1806d2c074" />

---

> \[!WARNING]
>
> 1. **Калибровка требует полного цикла заряд–разряд.** Используйте `shutdown /h` только после полной зарядки аккумулятора, и оставьте устройство разряжаться в гибернации до автоматического выключения. После этого необходимо выполнить полную зарядку без прерываний.
> 2. **Удаление схем питания (`powercfg /restoredefaultschemes`) необратимо.** Пользовательские схемы будут утеряны.
> 3. **Отчёты `sleepstudy` работают только на системах с Modern Standby.** На других версиях Windows файл создаётся пустым.
> 4. **Некоторые ошибки в отчётах `energy` являются системными и не устраняются вручную.** Используйте их для аудита, не как абсолютный показатель.

## `RDP_Client_Setup.bat` и `RDP_Server_Setup.bat` — настройка RDP-клиента и сервера

**Назначение:**
Сценарии автоматизируют настройку удалённого подключения по RDP. `RDP_Server_Setup.bat` включает серверную часть: разрешает подключения, настраивает фаервол, запускает службы. `RDP_Client_Setup.bat` обеспечивает подготовку клиента: проверяет доступность удалённой машины, открытость порта и запускает клиент с автофокусом.

**Применение:**
Используются при первичной настройке удалённого доступа к устройствам Windows (в рамках сети), обслуживании, быстром развертывании RDP-сессий, а также для диагностики проблем доступа.

Команда для входа:
`mstsc /v:255.255.255.255:3389`

Где 255.1255.255.255 — IPv4 сервера.

---

### `RDP_Server_Setup.bat` — настройка сервера RDP

**Ключевые команды:**

* `reg add HKLM\SYSTEM\...\fDenyTSConnections /d 0` — разрешение входящих RDP-соединений;
* `netsh advfirewall firewall add rule ... 3389` — разрешение входящего трафика для порта RDP;
* `sc config TermService start= auto` + `net start TermService` — включение и запуск службы удалённых рабочих столов;
* `net localgroup "Пользователи удалённого рабочего стола"` — добавление текущего пользователя в группу RDP;
* `wmic os get localdatetime` — генерация имени лог-файла с текущей меткой времени.

**Синтаксис кода:**

| Синтаксис                                             | Назначение / Пояснение                                      |
| ----------------------------------------------------- | ----------------------------------------------------------- |
| `reg add "HKLM\SYSTEM\...\fDenyTSConnections" /d 0`   | Включает приём входящих RDP-подключений на уровне реестра   |
| `netsh advfirewall firewall add rule name="RDP 3389"` | Добавляет исключение для входящих подключений по порту 3389 |
| `net start TermService`                               | Явно запускает службу терминалов                            |
| `net localgroup ... /add`                             | Добавляет пользователя в группу с правами доступа по RDP    |

**Фрагмент кода:**

```bat
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
netsh advfirewall firewall add rule name="RDP 3389" dir=in action=allow protocol=TCP localport=3389
net start TermService
```

<details>
<summary>📄 Показать полный BAT-скрипт</summary>

```bat
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

:: Создание лог-файла с использованием WMIC для получения даты в формате YYYYMMDD_HHMMSS
for /f "tokens=2 delims==." %%i in ('wmic os get localdatetime /value') do set now=%%i
set logfile=%USERPROFILE%\Desktop\RDP_Server_Log_%now:~0,8%_%now:~8,6%.txt
echo [%time%] Начало настройки сервера RDP > "%logfile%"


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

```
</details>

**Особенности:**

* После запуска службы вручную создаётся лог `RDP_Server_Log_YYYYMMDD_HHMMSS.txt` на рабочем столе;
* Включает все зависимости: фаервол, служба, группа доступа, политика безопасности;
* Не требует перезагрузки после выполнения.

---

### `RDP_Client_Setup.bat` — диагностика и подключение клиента

**Ключевые команды:**

* `ping`, `netstat -an` — проверка доступности хоста и прослушивания порта 3389;
* `mstsc /v:IP /f` — запуск клиента удалённого рабочего стола в полноэкранном режиме;
* `for /f "tokens=2 delims==."` — получение даты и времени для лога;
* `echo [%time%]` → `>> %logfile%` — логирование шагов диагностики и попытки подключения.

**Синтаксис кода:**

| Синтаксис                                              | Назначение / Пояснение                                       |
| ------------------------------------------------------ | ------------------------------------------------------------ |
| `ping %remoteHost%`                                    | Проверка доступности целевого устройства по IP               |
| \`netstat -an                                          | find ":3389"\` — Проверка локального состояния порта 3389 (на целевой машине) |
| `mstsc /v:%remoteHost% /f`                             | Автоматический запуск RDP-подключения в полноэкранном режиме |
| `set logfile=%USERPROFILE%\Desktop\RDP_Client_Log_...` | Создание лога подключения с временной меткой                 |

**Фрагмент кода:**

```bat
ping %remoteHost% >> "%logfile%"
netstat -an | find ":3389" >> "%logfile%"
mstsc /v:%remoteHost% /f
```

<details>
<summary>📄 Показать полный BAT-скрипт</summary>

```bat
@echo off
echo Batch File by MrWindows

chcp 65001 > nul
:: chcp 1251 > nul

setlocal enabledelayedexpansion
color 0a
title RDP Client Setup
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

```
</details>

**Особенности:**

* Запрашивает у пользователя IP-адрес или имя хоста для подключения;
* Сохраняет пошаговую диагностику в лог;
* Подходит для оперативной проверки доступности сервера и немедленного подключения;
* Учитывает ситуацию, когда RDP-порт может быть закрыт или недоступен из-за настроек.

---

**Логирование:**

Оба скрипта ведут текстовый лог выполнения с таймстемпом в имени, сохраняемый на рабочий стол пользователя:

```
%USERPROFILE%\Desktop\RDP_Client_Log_YYYYMMDD_HHMMSS.txt  
%USERPROFILE%\Desktop\RDP_Server_Log_YYYYMMDD_HHMMSS.txt
```

1. **Что логируется:**
   * Дата и время запуска скрипта;
   * Основные этапы выполнения (например: добавление правил в фаервол, запуск службы, диагностика порта);
   * Результаты команд `ping`, `netstat`, `reg add`, `net start` и др.

2. **Зачем логируется:**
   * Для подтверждения успешного выполнения конфигурации;
   * Для диагностики, если подключение не работает (например, порт не открыт, служба не запускается);
   * Чтобы сохранить результат и передать его в поддержку при необходимости.

3. **Особенности:**
   * Формат имени: `RDP_Client_Log_ГГГГММДД_ЧЧММСС.txt` — формируется через `wmic os get localdatetime`;
   * Лог формируется через `echo ... >> %logfile%`, что позволяет добавлять новые строки без перезаписи;
   * Лог создаётся независимо от исхода — успешного или с ошибкой.
  
<details>
<summary>🔍 Пример лога RDP_Server_Log</summary>

```log
[23:48:21,04] Начало настройки сервера RDP 
The operation completed successfully.

[23:48:21,08] RDP сервер включён в реестре 
Ok.

[23:48:21,23] Правило брандмауэра добавлено 
The following services are dependent on the  *** service.
Stopping the  *** service will also stop these services.

    ***

Do you want to continue this operation? (Y/N) [N]: The requested service has already been started.

More help is available by typing NET HELPMSG 2182.

[SC] ChangeServiceConfig SUCCESS
[23:51:03,93] Служба TermService перезапущена 

User accounts for \\ ***

-------------------------------------------------------------------------------
DefaultAccount            ***                   SyncthingServiceAcct     
WDAGUtilityAccount        ***            ***                    
The command completed successfully.

[23:51:03,97] Список пользователей выведен 

Windows IP Configuration

   Host Name . . . . . . . . . . . . : ***
   Primary Dns Suffix  . . . . . . . : 
   Node Type . . . . . . . . . . . . : Hybrid
   IP Routing Enabled. . . . . . . . : No
   WINS Proxy Enabled. . . . . . . . : No

Ethernet adapter Ethernet:

   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : Intel(R) Ethernet Connection (2) I218-V
   Physical Address. . . . . . . . . : ***
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   Link-local IPv6 Address . . . . . : FFFF::FFFF:FFFF:FFFF:FFFF
   IPv4 Address. . . . . . . . . . . : 255.255.255.255
   Subnet Mask . . . . . . . . . . . : 255.255.255.255
   Lease Obtained. . . . . . . . . . : 5  ¢£㡢  2025 £. 15:11:12
   Lease Expires . . . . . . . . . . : 6  ¢£㡢  2025 £. 15:11:12
   Default Gateway . . . . . . . . . : 255.255.255.255
   DHCP Server . . . . . . . . . . . : 255.255.255.255
   DHCPv6 IAID . . . . . . . . . . . : ***
   DHCPv6 Client DUID. . . . . . . . : ***
   DNS Servers . . . . . . . . . . . : ***
                                         DoH: https://dns.google/dns-query
                                       ***
                                       255.255.255.255
   NetBIOS over Tcpip. . . . . . . . : Enabled


Ethernet adapter Ethernet 4:

   Media State . . . . . . . . . . . : Media disconnected
   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : TAP-Windows Adapter V9 #2
   Physical Address. . . . . . . . . : ***
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes

Ethernet adapter VMware Network Adapter VMnet8:

   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : VMware Virtual Ethernet Adapter for VMnet8
   Physical Address. . . . . . . . . : ***
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   Link-local IPv6 Address . . . . . : FFFF::FFFF:FFFF:FFFF:FFFF
   IPv4 Address. . . . . . . . . . . : 255.255.255.255
   Subnet Mask . . . . . . . . . . . : 255.255.255.255
   Lease Obtained. . . . . . . . . . : 5  ¢£㡢  2025 £. 15:11:27
   Lease Expires . . . . . . . . . . : 6  ¢£㡢  2025 £. 0:16:16
   Default Gateway . . . . . . . . . : 
   DHCP Server . . . . . . . . . . . : 255.255.255.255
   DHCPv6 IAID . . . . . . . . . . . : ***
   DHCPv6 Client DUID. . . . . . . . : ***
   Primary WINS Server . . . . . . . : 255.255.255.255
   NetBIOS over Tcpip. . . . . . . . : Enabled

Ethernet adapter vEthernet (Default Switch):

   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : Hyper-V Virtual Ethernet Adapter
   Physical Address. . . . . . . . . : FF-FF-FF-FF-FF-FF
   DHCP Enabled. . . . . . . . . . . : No
   Autoconfiguration Enabled . . . . : Yes
   Link-local IPv6 Address . . . . . : FFFF::FFFF:FFFF:FFFF:FFFF
   IPv4 Address. . . . . . . . . . . : 255.255.255.255
   Subnet Mask . . . . . . . . . . . : 255.255.255.255
   Default Gateway . . . . . . . . . : 
   DHCPv6 IAID . . . . . . . . . . . : ***
   DHCPv6 Client DUID. . . . . . . . : ***
   NetBIOS over Tcpip. . . . . . . . : Enabled
[23:51:04,01] Сетевые настройки сохранены 
[23:51:04,02] Запуск диагностики сервера 

HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server
    fDenyTSConnections    REG_DWORD    0x0

  TCP    0.0.0.0:3389           0.0.0.0:0              LISTENING       1344
  TCP    [::]:3389              [::]:0                 LISTENING       1344
  UDP    0.0.0.0:3389           *:*                                    1344
  UDP    [::]:3389              *:*                                    1344
[23:51:04,07] Порт 3389 активен 
        STATE              : 4  RUNNING 
[23:51:04,12] Настройка сервера завершена успешно 

```

</details>

<details>
<summary>🔍 Пример лога RDP_Client_Log</summary>

```log
[23:47:32,57] Начало настройки клиента RDP 
[23:47:32,57] Проверка сетевых компонентов 

Windows IP Configuration

   Host Name . . . . . . . . . . . . : ***
   Primary Dns Suffix  . . . . . . . : 
   Node Type . . . . . . . . . . . . : Hybrid
   IP Routing Enabled. . . . . . . . : No
   WINS Proxy Enabled. . . . . . . . : No

Ethernet adapter Ethernet:

   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : Intel(R) Ethernet Connection (2) I218-V
   Physical Address. . . . . . . . . : ***
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   Link-local IPv6 Address . . . . . : FFFF::FFFF:FFFF:FFFF:FFFF
   IPv4 Address. . . . . . . . . . . : 255.255.255.255
   Subnet Mask . . . . . . . . . . . : 255.255.255.255
   Lease Obtained. . . . . . . . . . : 5  ¢£㡢  2025 £. 15:11:12
   Lease Expires . . . . . . . . . . : 6  ¢£㡢  2025 £. 15:11:12
   Default Gateway . . . . . . . . . : 255.255.255.255
   DHCP Server . . . . . . . . . . . : 255.255.255.255
   DHCPv6 IAID . . . . . . . . . . . : ***
   DHCPv6 Client DUID. . . . . . . . : ***
   DNS Servers . . . . . . . . . . . : ***
                                         DoH: https://dns.google/dns-query
                                       ***
                                       255.255.255.255
   NetBIOS over Tcpip. . . . . . . . : Enabled


Ethernet adapter Ethernet 4:

   Media State . . . . . . . . . . . : Media disconnected
   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : TAP-Windows Adapter V9 #2
   Physical Address. . . . . . . . . : ***
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes

Ethernet adapter VMware Network Adapter VMnet8:

   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : VMware Virtual Ethernet Adapter for VMnet8
   Physical Address. . . . . . . . . : ***
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   Link-local IPv6 Address . . . . . : FFFF::FFFF:FFFF:FFFF:FFFF
   IPv4 Address. . . . . . . . . . . : 255.255.255.255
   Subnet Mask . . . . . . . . . . . : 255.255.255.255
   Lease Obtained. . . . . . . . . . : 5  ¢£㡢  2025 £. 15:11:27
   Lease Expires . . . . . . . . . . : 6  ¢£㡢  2025 £. 0:16:16
   Default Gateway . . . . . . . . . : 
   DHCP Server . . . . . . . . . . . : 255.255.255.255
   DHCPv6 IAID . . . . . . . . . . . : ***
   DHCPv6 Client DUID. . . . . . . . : ***
   Primary WINS Server . . . . . . . : 255.255.255.255
   NetBIOS over Tcpip. . . . . . . . : Enabled

Ethernet adapter vEthernet (Default Switch):

   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : Hyper-V Virtual Ethernet Adapter
   Physical Address. . . . . . . . . : FF-FF-FF-FF-FF-FF
   DHCP Enabled. . . . . . . . . . . : No
   Autoconfiguration Enabled . . . . : Yes
   Link-local IPv6 Address . . . . . : FFFF::FFFF:FFFF:FFFF:FFFF
   IPv4 Address. . . . . . . . . . . : 255.255.255.255
   Subnet Mask . . . . . . . . . . . : 255.255.255.255
   Default Gateway . . . . . . . . . : 
   DHCPv6 IAID . . . . . . . . . . . : ***
   DHCPv6 Client DUID. . . . . . . . : ***
   NetBIOS over Tcpip. . . . . . . . : Enabled

Admin State    State          Type             Interface Name
-------------------------------------------------------------------------
Enabled        Disconnected   Dedicated        Ethernet 2
Enabled        Disconnected   Dedicated        OpenVPN Data Channel Offload
Enabled        Disconnected   Dedicated        Ethernet 4
Enabled        Connected      Dedicated        VMware Network Adapter VMnet1
Enabled        Connected      Dedicated        VMware Network Adapter VMnet8
Enabled        Connected      Dedicated        Ethernet


Deployment Image Servicing and Management tool
Version: 10.0.22621.2792

Image Version: 10.0.22631.5624


Error: 0x800f080c

¬®¬¯®­¥­⠠"RemoteDesktopClient" ­¥¨§¢¥᢭®.
¬®¬¯®­¥­⠠Windows ­¥ ࠡ¯®§­ ­®.
®ᯮ«짣©⥡젯 ࠬ¥⠮¬ /Get-Features, 碮¡렭 ©⨠¨¬®¬¯®­¥­⠠¢ ®¡ࠧ¥, ¨ ¯®¢⮠¨⥠ª®¬ ­¤㮍

The DISM log file can be found at C:\Windows\Logs\DISM\dism.log
[23:47:33,06] Компонент RemoteDesktopClient включен 

Deployment Image Servicing and Management tool
Version: 10.0.22621.2792

Image Version: 10.0.22631.5624

ª«­¨¥ 䣭ª権

[                           0.1%                           ] 

[=======                    12.5%                          ] 

[========                   15.0%                          ] 

[==========                 17.5%                          ] 

[===========                20.0%                          ] 

[=============              22.5%                          ] 

[==============             25.0%                          ] 

[===============            27.5%                          ] 

[=================          30.0%                          ] 

[==================         31.7%                          ] 

[===================        33.4%                          ] 

[==========================100.0%==========================] 
The operation completed successfully.
[23:47:44,00] Telnet Client включен 
[23:48:01,58] Тестирование подключения к ***

Pinging 192.168.0.1 with 32 bytes of data:
Request timed out.
Request timed out.
Request timed out.
Request timed out.

Ping statistics for 192.168.0.1:
    Packets: Sent = 4, Received = 0, Lost = 4 (100% loss),
[23:48:20,32] ОШИБКА: Устройство *** недоступно по ping 
[23:48:20,36] ОШИБКА: Порт 3389 на 192.168.0.1 недоступен 
[23:48:20,36] Настройка клиента завершена 

```

</details>

> \[!WARNING]
>
> 1. На Home-редакциях Windows серверная часть RDP недоступна. Используйте только на Windows Pro/IoT/Enterprise.
> 2. Для работы необходимо, чтобы порт 3389 был доступен в сети. Отключённый фаервол или проброшенный NAT — обязательны.
> 3. Служба TermService должна быть активна. В ряде случаев её необходимо включить вручную или через групповые политики.
> 4. При первом запуске может потребоваться разрешение доступа в UAC. Все действия требуют прав администратора.

## 🧾 Сбор логов установщика и анализ через WiLogUtl

Скрипт: `log_dumper.bat`:
```bat
@echo off
set LOGPATH="%USERPROFILE%\Desktop\OfficeInstall.log"
msiexec /i "C:\MS_Office_2010\MS_Office_2010\setup.exe" /L*v %LOGPATH%
pause
```

**Назначение:**
Сценарий предназначен для автоматизированного сбора установочных логов Windows Installer (MSI), системной информации и событий Windows. Формирует диагностический архив, пригодный для анализа с помощью `WiLogUtl` и других утилит. Подходит для подготовки обращения в поддержку, внутреннего аудита и локализации проблем при установке ПО.

**Рекомендуется для использования:**
- При неудачной установке/обновлении программ;
- Для подготовки логов перед передачей инцидента L2/L3;
- В процессе ручного/автоматизированного развёртывания ПО;
- При сбоях, связанных с MSI, `setup.exe`, `msiexec`.

---

**Синтаксис кода:**

| Синтаксис                                                       | Назначение / Пояснение                                                                 |
|------------------------------------------------------------------|----------------------------------------------------------------------------------------|
| `set LOGPATH="%USERPROFILE%\Desktop\OfficeInstall.log"`          | Переменная среды для указания пути сохранения установочного лога                      |
| `msiexec /i "C:\Path\to\setup.msi" /L*v %LOGPATH%`               | Установка MSI-пакета с логированием (`/L*v`) в файл `OfficeInstall.log`               |
| `/L*v`                                                           | Ключ для подробного логирования: все действия, ошибки, предупреждения (`verbose`)     |


**Особенности:**
- Использует встроенный инструмент `msiexec`;
- Создаёт подробный лог установки MSI-пакета по пути:  
  `%USERPROFILE%\Desktop\OfficeInstall.log`;
- Не требует дополнительных утилит или библиотек;
- Простой и понятный пример того, как выполнять логирование установки.

## Анализ логов установки через WiLogUtl
Созданный лог-файл установки (`OfficeInstall.log`) можно проанализировать с помощью официальной утилиты от Microsoft — **WiLogUtl.exe**.

**Что такое WiLogUtl?**

**WiLogUtl** — это визуальный инструмент, позволяющий анализировать пошаговое выполнение MSI-установки. Позволяет быстро определить причины ошибки установки, например: `Error 1603`, сбои условий установки, проблемы с правами доступа, зависимостями и т.д.

## Установка WiLogUtl

WiLogUtl входит в состав **Windows SDK**.

1. Перейдите на официальный сайт:  
   [https://developer.microsoft.com/en-us/windows/downloads/sdk-archive](https://developer.microsoft.com/en-us/windows/downloads/sdk-archive)
2. Скачайте версию Windows SDK, совместимую с вашей ОС.
3. Во время установки **выберите только компонент: "Debugging Tools for Windows"** — этого достаточно.

> После установки WiLogUtl обычно находится по пути:
> ```
> C:\Program Files (x86)\Windows Kits\10\bin\10.0.xxxxx.x\x86\WiLogUtl.exe
> ```

---

## 📂 Как использовать

1. Запустите `WiLogUtl.exe`
2. Укажите путь к лог-файлу, созданному скриптом:
3. Нажать "Analyze" — откроется дерево шагов установки.

<img width="665" height="549" alt="image" src="https://github.com/user-attachments/assets/c446a821-695a-43d8-ab2b-7cd489e7c068" />

Таким образом **WiLogUtl** проводит парсинг лога, где указывает:
- Основные ошибки, например: ` Установка завершена с состоянием: 1603.`
- Другие вспомогательные данные, такие как `Client Details` и `Server Details`

Далее мы можем сохранить результат в виде `.txt` или `.html` формата. Они подойдут для отчёта, который будет задержать: `log_Errors`, `log_Policies` и `log_Summary`

<img width="2560" height="957" alt="msedge_BxQPHyMfPC" src="https://github.com/user-attachments/assets/69c3b43a-fb2c-4494-b57b-14276f5d98ed" />

<details>
<summary>🔍 Пример после парсинга лога</summary>

```txt
Errors Found For Log File D:\Office\logs\2\OfficeInstall.log
======================================================

4 Non-Ignored Errors
======================================================
-------------------------------------------------
Believed Error Found:

Error 1713. Setup cannot install one of the required products for Microsoft Office Professional Plus 2010.  
MSI (s) (00!F8) [20:06:45:443]: Product: Microsoft Office Professional Plus 2010 -- Error 1713. Setup cannot install one of the required products for Microsoft Office Professional Plus 2010.  

CustomAction AbortMsi returned actual error code 1603 (note this may not be 100% accurate if translation happened inside sandbox)
Action ended 20:06:45: AbortMsi. Return value 3.


Proposed Solution To Error:
  A standard action or custom action caused the failure.

-------------------------------------------------
Believed Error Found:
Error 1713. Setup cannot install one of the required products for Microsoft Office Professional Plus 2010.  
MSI (s) (00!F8) [20:06:45:443]: Product: Microsoft Office Professional Plus 2010 -- Error 1713. Setup cannot install one of the required products for Microsoft Office Professional Plus 2010.  

CustomAction AbortMsi returned actual error code 1603 (note this may not be 100% accurate if translation happened inside sandbox)
Action ended 20:06:45: AbortMsi. Return value 3.
Action ended 20:06:45: INSTALL. Return value 3.


Proposed Solution To Error:
  A standard action or custom action caused the failure.

-------------------------------------------------
Believed Error Found:
MSI (s) (00:98) [20:06:45:521]: Restoring environment variables
MSI (s) (00:98) [20:06:45:521]: Destroying RemoteAPI object.
MSI (s) (00:B4) [20:06:45:521]: Custom Action Manager thread ending.
MSI (c) (04:DC) [20:06:45:537]: Back from server. Return value: 1603
MSI (c) (04:DC) [20:06:45:537]: Decrementing counter to disable shutdown. If counter >= 0, shutdown will be denied.  Counter after decrement: -1
Action ended 20:06:45: INSTALL. Return value 3.


Proposed Solution To Error:
  A standard action or custom action caused the failure.

-------------------------------------------------
Believed Error Found:

MSI (c) (04:DC) [20:06:45:552]:            Windows                            .        : Microsoft Office Professional Plus 2010.       : 14.0.4763.1000.     : 0.             : Microsoft Corporation.                                 : 1603.

MSI (c) (04:DC) [20:06:45:568]: Grabbed execution mutex.
MSI (c) (04:DC) [20:06:45:568]: Cleaning up uninstalled install packages, if any exist
MSI (c) (04:DC) [20:06:45:568]: MainEngineThread is returning 1603


Proposed Solution To Error:
                                                    .



0 Ignored Errors
======================================================
-------------------------------------------------
Believed Error Found:
No Error Found!

Proposed Solution To Error:
  No Solution Needed!


```

</details>

### Что искать в логах

- **Ошибки установки**: `Error 1603`, `Error 1935`, `Access Denied`
- **Прерванные действия**: записи типа `Rolling back action`
- **Ошибки прав доступа**: строки с `Denied`, `Permission`, `Impersonate`
- **Циклы и условия**: логика `Condition Failed`, `Skipped`

### ⚠️ Ограничения WiLogUtl

- Не показывает **внешний контекст ошибки** — например, конфликты с антивирусом, внешними процессами, сетевыми зависимостями.
- Не отображает **последовательность действий вне MSI**, таких как запуск скриптов, внешних приложений, команд оболочки.
- Не может анализировать `.etl`, `.cab` или другие системные логи — только `MSI .log`.
- Интерфейс не поддерживает полнотекстовый поиск — просмотр больших логов может быть неудобен.

### 🧰 Альтернативы и дополнения

| Инструмент         | Поддержка форматов         | Особенности                                                       |
|--------------------|----------------------------|--------------------------------------------------------------------|
| **Microsoft Log Parser 2.2** | любая текстовая система, `.log`, CSV, Event Log, реестр :contentReference[oaicite:2]{index=2} | SQL‑подобные запросы к логам, работает с любым `.log`               |
| **CMTrace.exe**    | текстовые `.log`, включая MSI и custom logs :contentReference[oaicite:3]{index=3} | Подсветка ошибок, фильтрация, просмотр в реальном времени           |
| **LogGrok**        | MSI-логи и произвольные `.log` (open-source) :contentReference[oaicite:4]{index=4} | Фильтрация, regex, визуализация действий установки и пользовательских сценариев |

### 📘 Полезные ссылки

- [Документация по WiLogUtl](https://learn.microsoft.com/en-us/windows/win32/msi/wilogutl-exe)
- [Расшифровка MSI ошибок (Error Codes)](https://learn.microsoft.com/en-us/windows/win32/msi/error-codes)

---

📌 Использование `log_dumper.bat` в сочетании с WiLogUtl демонстрирует **умение собирать и анализировать установочные логи** — важный навык для технической поддержки

