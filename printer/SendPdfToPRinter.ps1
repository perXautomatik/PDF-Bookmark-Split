



$adobe= Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\*\Products\*\InstallProperties" | Where-Object { $_.getValue('DisplayName') -like "*acrobat reader*" } | ForEach-Object { $_.getValue('InstallLocation') + "/reader/AcroRd32.exe"} 
$printername = ((get-printer | where-object {$_.name -like '*2339*'} |format-table -property name -HideTableHeaders| out-string ).toString()).trim()
$drivername = ((get-printer | where-object {$_.name -like '*2339*'} |format-table -property drivername -HideTableHeaders|out-string).toString()).trim()
$portname = """ + ((get-printer | where-object {$_.name -like '*2339*'} |format-table -property portname -HideTableHeaders|out-string).toString()).trim() + """
$pdf='C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\1494870C-9912-C184-4CC9-B401-A53F4D8DE290.pdf'

$arglist='/t "{0}" "{1}" "{2}" {3}' -f $pdf, $printername, $drivername, $portname

#Start-Process $adobe -ArgumentList $arglist



$wshNet = New-Object -ComObject WScript.Network
$wshNet.SetDefaultPrinter($printername)

Start-Process -FilePath $pdf -Verb Print 