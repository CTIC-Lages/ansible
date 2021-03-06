#================================================================
#
# Author: Anderson F. de Almeida @ IFSC
# Created: 14/09/2015
# Designed for simple backups and folder cleaning  
# C.T.I.C. Câmpus Lages
#
#================================================================
#net use u: \\10.150.0.12\Instaladores

[Environment]::SetEnvironmentVariable("Tarefas", "0", "Machine")

$origem = "C:\Users\*\Desktop\*"
$destino = "C:\Users\*\Documents\"

# Backup
copy-item -exclude *.lnk,*.ini,*.iso,*.ccd,*.sub,*.cue,*.bin,*.cso,*.daa,*.ibp,*.ibq,*.isz,*.mds,*.mdf,*.mdx,*.nrg,*.uif,*.wim -recurse -force $origem -destination $destino 

# Verify for Update Disponibility
#$Update = "U:\LAB\Update.txt"
if (test-path $Update){
    Invoke-Expression U:\LAB\scripts\Shutdown.ps1
}

# Cleaning
if ($TempIEFiles) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 8} 
    if ($Cookies) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 2} 
    if ($History) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 1} 
    if ($FormData) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 16} 
    if ($Passwords) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 32 } 
    if ($All) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 255} 
    if ($AddOnSettings) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 4351 }
$temp = @("C:\Windows\Temp\*","C:\Windows\Prefetch\*","C:\Users\*\AppData\Local\Temp\*","C:\Users\*\Desktop\*","C:\Users\*\Downloads\*","C:\Users\Public\Desktop\*","C:\Users\*\AppData\Local\Google\Chrome\User Data\*","C:\Users\*\AppData\Local\Mozilla\Firefox\Profiles\*","C:\Users\*\AppData\Local\Opera Software\Opera Stable\*")
remove-item $temp -force -recurse

[Environment]::SetEnvironmentVariable("Tarefas", "1", "Machine")

# Remove mapped drive U:
# net use U: /delete