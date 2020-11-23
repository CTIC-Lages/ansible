## Compara o endereço mac e seta o nome de máquina

$list= Import-Csv \\acad02.lages.ifsc.edu.br\AcessoLivre\bruno\endereco_mac_116.csv

net use L: \\acad02.lages.ifsc.edu.br\AcessoLivre\bruno

$mac  = Get-WmiObject win32_networkadapterconfiguration | select IPAddress, macaddress |
where-object{$_.IPAddress -match "10.151*" -and $_.macaddress -match "F4:8E*" -or $_.macaddress -match "20:47" }
$mac.macaddress
$mac.IPAddress = [string]$mac.IPAddress
Write-Host "--------------------------"

foreach($l in $list){
    if ($l.Macaddress -eq $mac.macaddress){
       $nomeComputador = $env:COMPUTERNAME 
        
       Rename-computer –newname $l.hostname -force
      #  Write-Host "foi"
    }
}


net use L: /delete



