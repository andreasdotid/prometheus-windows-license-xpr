cscript c:\Windows\System32\slmgr.vbs /xpr > "C:\Program Files (x86)\windows_exporter\textfile_inputs\slmgr_result.txt"

$now = Get-Date
$xprdate = Get-Content "C:\Program Files (x86)\windows_exporter\textfile_inputs\slmgr_result.txt" | Where-Object{$_ -match 'expire'} | ForEach-Object {([string]$_).Split(" ")[8] }
$xprDateObj = Get-Date -Date $xprdate

$getRemainDays = $xprDateObj - $now
echo $getRemainDays > "C:\Program Files (x86)\windows_exporter\textfile_inputs\license_remaining_days.txt"

$remainingDays = Get-Content "C:\Program Files (x86)\windows_exporter\textfile_inputs\license_remaining_days.txt" | Where-Object{$_ -match 'TotalDays'} | ForEach-Object {([string]$_).Split(" ")[10] }
echo $remainDays
Set-Content -Path "C:\Program Files (x86)\windows_exporter\textfile_inputs\slmgr_result.prom" -Encoding Ascii -NoNewline -Value ""
Add-Content -Path "C:\Program Files (x86)\windows_exporter\textfile_inputs\slmgr_result.prom" -Encoding Ascii -NoNewline -Value "# HELP windows_license_remaining_days Windows License Remaining Days`n"
Add-Content -Path "C:\Program Files (x86)\windows_exporter\textfile_inputs\slmgr_result.prom" -Encoding Ascii -NoNewline -Value "# TYPE windows_license_remaining_days gauge`n"
Add-Content -Path "C:\Program Files (x86)\windows_exporter\textfile_inputs\slmgr_result.prom" -Encoding Ascii -NoNewline -Value "windows_license_remaining_days ${remainingDays}`n"
