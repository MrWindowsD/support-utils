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

> Раздел в разработке. Инструкции по клонированию и запуску будут добавлены позже.

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
| `netsh int ip reset` | Сброс IP-настроек, применяется только в ручном режиме, не в этом скрипте. |

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
Особенности:
- Поддержка: Windows 10 и 11;
- Подходит для запуска от имени пользователя без доступа к GUI;
- Учитывает возможные проблемы с кодировкой, нестабильным адаптером и длинными маршрутами.

**Логирование:**
Все результаты диагностики сохраняются в текстовый файл, расположенный во временной папке текущего пользователя (`%TEMP%`).
Путь до лога:
```bat
set "log=%TEMP%\network_report.txt"
ipconfig /all >> "%log%"
```
Это универсальный путь, который работает без прав администратора и не зависит от имени пользователя или расположения скрипта. Где `>>` — это дозапись без перезаписи.
1. Что логируется:
- Состояние сетевых интерфейсов (ipconfig /all);
- Доступность внешнего адреса (ping);
- Маршрут до DNS (tracert);
- Отступы (echo.) добавляются для удобства чтения.
2. Зачем логируем:
- Для последующего анализа проблемы или передачи отчёта технической поддержке;
- Чтобы пользователь не искал команды вручную в окне консоли;
- Возможность использовать лог как вложение к тикету или чату с саппортом.

> [!WARNING]
> 1. Блокировка ICMP из-за политики фаервола: многие сайты и маршрутизаторы блокируют ICMP‑эхо, поэтому даже работающий сайт может не отвечать на ping/tracert.
> 2. Ограничения на обработку пакетов большого размера: `ping -l 65500` требует прямой поддержки фрагментации, которую могут запрещать маршрутизаторы или DNS CDN. Проблема повышенной задержки без потерь может затушевать реальную суть.
> 3. Трэйсерут не всегда показывает полный маршрут: он использует TTL, но если промежуточный маршрутизатор не отвечает ICMP «Time exceeded», трассировка на этом месте обрывается.
> 4. Тайм-ауты и единичные результаты: ответа может не быть из-за сетевой перегруженности или превышения лимита — это не всегда означает обрыв связи.

<details>
<summary>Показать полный BAT-скрипт</summary>

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

## `pre_diag.bat` — базовая диагностика ОС Windows

**Назначение:**
Автоматизирует ключевые проверки целостности и стабильности Windows: выполняет восстановление компонентов через DISM, проверку системных файлов (`sfc`) и диагностику системного диска (`chkdsk`). Результаты отображаются в окне консоли и сохраняются в папку `C:\Logs`.

**Применение:**
Рекомендуется для устранения системных сбоев, предварительной диагностики перед тикетом в поддержку, подготовки ПК к переносу или массовому обслуживанию. Особенно актуально при возникновении BDOS, ошибок служб, нестабильности системы или жалобах пользователей

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

Особенности:

- Поддержка: Windows 10 и Windows 11;
- Требует запуска с правами администратора;
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

> \[!WARNING]
>
> 1. `chkdsk` — потребует перезагрузку системы;
> 2. `DISM` требует активного подключения к интернету или локального источника для восстановления;
> 3. `sfc` может ничего не показать в консоли, если ошибок не найдено — нужно проверить `CBS.log`;

<details>
<summary>Показать полный BAT-скрипт</summary>

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

## `office_profile_export.bat` — демонстрация автоматизации миграции пользовательского окружения Office

**Назначение:**
Сценарий демонстрирует подход к автоматизированной миграции среды пользователя и ключевых компонентов Microsoft Office при наличии локального доступа к исходному диску. Основное внимание уделено воспроизводимой структуре, параметризации и копированию реестра — без применения стороннего ПО.

**Применение:**
Скрипт разработан как **пример практической автоматизации**, применимый в следующих кейсах:

* Демонстрация навыков автоматизации переноса пользовательского окружения;
* Формирование шаблона для частичной миграции при смене ПК;
* Подготовка или изучение реестровых и файловых компонентов Microsoft Office для повторного использования или восстановления.

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

<details>
<summary>Показать полный BAT-скрипт</summary>

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

## `AutoBackupTools` — CLI-пакет автоматического резервного копирования ключевых пользовательских и системных данных

**Назначение:**
CLI-утилита, демонстрирующая автоматизацию резервного копирования пользовательских и системных данных с использованием стандартных средств Windows (**batch** и **VBS**). Пакет включает средства создания, очистки и планирования бэкапов, а также работу с планировщиком задач (**Task Scheduler**). Скрипт подчёркивает важность превентивной защиты от потери данных и может использоваться как шаблон для адаптации, а также при обучении резервирования.

**Применение:**
Используется в следующих сценариях:

* Демонстрация навыков CLI-автоматизации резервного копирования;
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
| `clearbackupgood.bat`        | Полностью очищает папку резервных копий. Находится в доработке из-за нестабильности выполнения задачи в системах авами. |
| `delet autobackup.bat`       | Удаляет созданную задачу. |

> \[!NOTE]
> Основной функционал работает стабильно: создание, копирование, автоматизация.
> В стадии доработки:
>   * `delet autobackup.bat`: неполная поддержка удаления задачи на локализованных системах Windows;
>   * возможность расширения механизма версионирования и создания архивов;
>   * оптимизация логирования и очистки.

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
| `takeown /F ... /R`                            | Передаёт права на директорию — нужно для запуска от имени пользователя                        |
| `set /p choice=`                               | Запрашивает у пользователя выбор режима запуска и очистки                                     |

---

**Фрагмент кода:**

```bat
xcopy /s "%~dp0\startup\backupgood.bat" "C:\startupbackupsystem"
schtasks /create /tn "BackupTask" /sc onlogon /rl HIGHEST /f /tr C:\startupbackupsystem\backupgood.bat /np
```

---

**Особенности:**

* Позволяет выбрать режим запуска: при входе, ежечасно, ежедневно, еженедельно, ежемесячно;
* Обеспечивает автоматический запуск копирования и очистки без участия пользователя;
* Все действия выполняются средствами Windows CLI, без внешних зависимостей.

<details>
<summary>Показать полный BAT-скрипт</summary>

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

`delet autobackup.bat` — используется для удаления задачи из планировщика и очистки остаточных файлов.

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

---

**Особенности:**

* Автоматически запускает все необходимые службы, включая `Volume Shadow Copy`, `Remote Registry`, `System Restore Service`;
* Создаёт структуру резервных копий с разбивкой по дате (`C:\backup\registry\DD.MM.YYYY`);
* Использует только встроенные средства Windows, без стороннего ПО;
* Запускается как вручную, так и автоматически из задач, созданных `autobackup.bat`;
* Выполняется "тихо", то есть в фоне.

<details>
<summary>Показать полный BAT-скрипт</summary>

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

`clearbackupgood.bat` — данный же BAT-скрипт выполняет очистку копий с заданными параметрами планировщика.

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

---

**Особенности:**

* Работает на всех версиях Windows с поддержкой WMI и WSH;
* Не требует прав администратора, если скрипт вызывается из `backupgood.bat`, запущенного от имени администратора;
* Может быть переиспользован как самостоятельный инструмент для инвентаризации служб;
* Совместим с форматом `regedit` — полученный `.reg` можно применить на другой машине для восстановления режима запуска служб.

<details>
<summary>Показать полный BAT-скрипт</summary>

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

`AutoBackupTools` демонстрирует подход к построению автономного CLI-инструмента для резервного копирования без использования стороннего ПО.
Ключевые аспекты проекта:

* Разделение логики на независимые сценарии с возможностью доработки;
* Работа с `Task Scheduler`, `WMI`, `VSS`, `Registry` — в реальных административных задачах;
* Возможность адаптации под задачи восстановления, аудита и защиты пользовательских конфигураций;
* Реализация полного цикла: от копирования до автоматической очистки, с гибкой настройкой расписаний.

Проект остаётся в состоянии доработки (например, `delet autobackup.bat`), но уже сейчас применим как обучающий шаблон для L1/L2-специалистов и системных администраторов.

Справедливо. Ошибся, что не включил раздел про логирование и **не дал инженерных предупреждений**, особенно по калибровке и потенциальным рискам при использовании `powercfg`. Сейчас всё будет — строго, глубоко, по делу:

---

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

---

**Логирование:**

1. **Файлы отчётов:**

   * `battery_report.html` — полный отчёт об аккумуляторе (проектная ёмкость, износ, история циклов);
   * `energy_report.html` — список проблем в управлении питанием;
   * `sleepstudy_report.html` — отчёт о переходах в режим сна (если поддерживается).
     Все отчёты сохраняются на рабочий стол пользователя (`%USERPROFILE%\Desktop`).

---

> \[!WARNING]
>
> 1. **Калибровка требует полного цикла заряд–разряд.** Используйте `shutdown /h` только после полной зарядки аккумулятора, и оставьте устройство разряжаться в гибернации до автоматического выключения. После этого необходимо выполнить полную зарядку без прерываний.
> 2. **Удаление схем питания (`powercfg /restoredefaultschemes`) необратимо.** Пользовательские схемы будут утеряны.
> 3. **Отчёты `sleepstudy` работают только на системах с Modern Standby.** На других версиях Windows файл создаётся пустым.
> 4. **Некоторые ошибки в отчётах `energy` являются системными и не устраняются вручную.** Используйте их для аудита, не как абсолютный показатель.

<details>
<summary>Показать полный BAT-скрипт</summary>

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

## `RDP_Client_Setup.bat` и `RDP_Server_Setup.bat` — настройка RDP-клиента и сервера

**Назначение:**
Сценарии автоматизируют настройку удалённого подключения по RDP. `RDP_Server_Setup.bat` включает серверную часть: разрешает подключения, настраивает фаервол, запускает службы. `RDP_Client_Setup.bat` обеспечивает подготовку клиента: проверяет доступность удалённой машины, открытость порта и запускает клиент с автофокусом.

**Применение:**
Используются при первичной настройке удалённого доступа к устройствам Windows (в рамках сети), обслуживании, быстром развертывании RDP-сессий, а также для диагностики проблем доступа.

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

**Особенности:**

* После запуска службы вручную создаётся лог `RDP_Server_Log_YYYYMMDD_HHMMSS.txt` на рабочем столе;
* Включает все зависимости: фаервол, служба, группа доступа, политика безопасности;
* Не требует перезагрузки после выполнения.

<details>
<summary>Показать полный BAT-скрипт</summary>

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

**Особенности:**

* Запрашивает у пользователя IP-адрес или имя хоста для подключения;
* Сохраняет пошаговую диагностику в лог;
* Подходит для оперативной проверки доступности сервера и немедленного подключения;
* Учитывает ситуацию, когда RDP-порт может быть закрыт или недоступен из-за настроек.

<details>
<summary>Показать полный BAT-скрипт</summary>

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

---

> \[!WARNING]
>
> 1. На Home-редакциях Windows серверная часть RDP недоступна. Используйте только на Windows Pro/IoT/Enterprise.
> 2. Для работы необходимо, чтобы порт 3389 был доступен в сети. Отключённый фаервол или проброшенный NAT — обязательны.
> 3. Служба TermService должна быть активна. В ряде случаев её необходимо включить вручную или через групповые политики.
> 4. При первом запуске может потребоваться разрешение доступа в UAC. Все действия требуют прав администратора.
