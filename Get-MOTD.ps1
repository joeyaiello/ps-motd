function Get-MOTD {
    # Perform WMI Queries
    $Wmi_OperatingSystem = Get-WmiObject -Query 'Select lastbootuptime,TotalVisibleMemorySize,FreePhysicalMemory,caption,version From win32_operatingsystem'
    $Wmi_Processor = Get-WmiObject -Query 'Select Name,LoadPercentage From Win32_Processor'
    $Wmi_LogicalDisk = Get-WmiObject -Query 'Select Size,FreeSpace From Win32_LogicalDisk Where DeviceID="C:"'

    # Assign variables
    $Date = Get-Date
    $OS = $Wmi_Operatingsystem.Caption
    $Kernel = $Wmi_Operatingsystem.Version
    $Uptime = "$(($Uptime = $Date - $Wmi_Operatingsystem.ConvertToDateTime($Wmi_Operatingsystem.LastBootUpTime)).Days) days, $($Uptime.Hours) hours, $($Uptime.Minutes) minutes"
    $Shell = "{0}.{1}" -f $PSVersionTable.PSVersion.Major,$PSVersionTable.PSVersion.Minor
    $CPU = $Wmi_Processor.Name -replace '\(C\)', '' -replace '\(R\)', '' -replace '\(TM\)', '' -replace 'CPU', '' -replace '\s+', ' '
    $Processes = (Get-Process).Count
    $CurrentLoad = $Wmi_Processor.LoadPercentage
    $Memory = "{0}mb/{1}mb Used" -f (([math]::round($Wmi_Operatingsystem.TotalVisibleMemorySize/1KB))-([math]::round($Wmi_Operatingsystem.FreePhysicalMemory/1KB))),([math]::round($Wmi_Operatingsystem.TotalVisibleMemorySize/1KB))
    $Disk = "{0}gb/{1}gb Used" -f (([math]::round($Wmi_LogicalDisk.Size/1GB))-([math]::round($Wmi_LogicalDisk.FreeSpace/1GB))),([math]::round($Wmi_LogicalDisk.Size/1GB))

    Write-Host ("")
    Write-Host ("")
    Write-Host ("         ,.=:^!^!t3Z3z.,                  ") -ForegroundColor Red
    Write-Host ("        :tt:::tt333EE3                    ") -ForegroundColor Red
    Write-Host ("        Et:::ztt33EEE ") -NoNewline -ForegroundColor Red
    Write-Host (" @Ee.,      ..,     ") -NoNewline -ForegroundColor Green
    Write-Host $Date -ForegroundColor Green
    Write-Host ("       ;tt:::tt333EE7") -NoNewline -ForegroundColor Red
    Write-Host (" ;EEEEEEttttt33#     ") -ForegroundColor Green
    Write-Host ("      :Et:::zt333EEQ.") -NoNewline -ForegroundColor Red
    Write-Host (" SEEEEEttttt33QL     ") -NoNewline -ForegroundColor Green
    Write-Host ("User: ") -NoNewline -ForegroundColor Red
    Write-Host ("$env:username") -ForegroundColor Cyan
    Write-Host ("      it::::tt333EEF") -NoNewline -ForegroundColor Red
    Write-Host (" @EEEEEEttttt33F      ") -NoNewline -ForeGroundColor Green
    Write-Host ("Hostname: ") -NoNewline -ForegroundColor Red
    Write-Host ("$env:computername") -ForegroundColor Cyan
    Write-Host ("     ;3=*^``````'*4EEV") -NoNewline -ForegroundColor Red
    Write-Host (" :EEEEEEttttt33@.      ") -NoNewline -ForegroundColor Green
    Write-Host ("OS: ") -NoNewline -ForegroundColor Red
    Write-Host $OS -ForegroundColor Cyan
    Write-Host ("     ,.=::::it=., ") -NoNewline -ForegroundColor Cyan
    Write-Host ("``") -NoNewline -ForegroundColor Red
    Write-Host (" @EEEEEEtttz33QF       ") -NoNewline -ForegroundColor Green
    Write-Host ("Kernel: ") -NoNewline -ForegroundColor Red
    Write-Host ("NT ") -NoNewline -ForegroundColor Cyan
    Write-Host $Kernel -ForegroundColor Cyan
    Write-Host ("    ;::::::::zt33) ") -NoNewline -ForegroundColor Cyan
    Write-Host ("  '4EEEtttji3P*        ") -NoNewline -ForegroundColor Green
    Write-Host ("Uptime: ") -NoNewline -ForegroundColor Red
    Write-Host $Uptime -ForegroundColor Cyan
    Write-Host ("   :t::::::::tt33.") -NoNewline -ForegroundColor Cyan
    Write-Host (":Z3z.. ") -NoNewline -ForegroundColor Yellow
    Write-Host (" ````") -NoNewline -ForegroundColor Green
    Write-Host (" ,..g.        ") -NoNewline -ForegroundColor Yellow
    Write-Host ("Shell: ") -NoNewline -ForegroundColor Red
    Write-Host ("Powershell $Shell") -ForegroundColor Cyan
    Write-Host ("   i::::::::zt33F") -NoNewline -ForegroundColor Cyan
    Write-Host (" AEEEtttt::::ztF         ") -NoNewline -ForegroundColor Yellow
    Write-Host ("CPU: ") -NoNewline -ForegroundColor Red
    Write-Host $CPU -ForegroundColor Cyan
    Write-Host ("  ;:::::::::t33V") -NoNewline -ForegroundColor Cyan
    Write-Host (" ;EEEttttt::::t3          ") -NoNewline -ForegroundColor Yellow
    Write-Host ("Processes: ") -NoNewline -ForegroundColor Red
    Write-Host $Processes -ForegroundColor Cyan
    Write-Host ("  E::::::::zt33L") -NoNewline -ForegroundColor Cyan
    Write-Host (" @EEEtttt::::z3F          ") -NoNewline -ForegroundColor Yellow
    Write-Host ("Current Load: ") -NoNewline -ForegroundColor Red
    Write-Host $CurrentLoad -NoNewline -ForegroundColor Cyan
    Write-Host ("%") -ForegroundColor Cyan
    Write-Host (" {3=*^``````'*4E3)") -NoNewline -ForegroundColor Cyan
    Write-Host (" ;EEEtttt:::::tZ``          ") -NoNewline -ForegroundColor Yellow
    Write-Host ("Memory: ") -NoNewline -ForegroundColor Red
    Write-Host $Memory -ForegroundColor Cyan
    Write-Host ("             ``") -NoNewline -ForegroundColor Cyan
    Write-Host (" :EEEEtttt::::z7            ") -NoNewline -ForegroundColor Yellow
    Write-Host ("Disk: ") -NoNewline -ForegroundColor Red
    Write-Host $Disk -ForegroundColor Cyan
    Write-Host ("                 'VEzjt:;;z>*``           ") -ForegroundColor Yellow
    Write-Host ("                      ````                  ") -ForegroundColor Yellow
    Write-Host ("")
}