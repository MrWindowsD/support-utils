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