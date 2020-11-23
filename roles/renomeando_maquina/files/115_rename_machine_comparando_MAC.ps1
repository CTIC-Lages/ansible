## Compara o endereço mac e seta o nome de máquina

$list= Import-Csv \\acad02.lages.ifsc.edu.br\AcessoLivre\bruno\endereco_mac_115.csv

$list.GetType()
net use L: \\acad02.lages.ifsc.edu.br\AcessoLivre\bruno

$mac  = Get-WmiObject win32_networkadapterconfiguration | select IPAddress, macaddress |
where-object{$_.IPAddress -match "10.151*" -and $_.macaddress -match "50:B3*" }
$mac.macaddress
$mac.IPAddress = [string]$mac.IPAddress
Write-Host "--------------------------"

foreach($l in $list){
    if ($l.Macaddress -eq $mac.macaddress){
    
       $nomeComputador = $env:computername
       RENAME-COMPUTER –computername $nomeComputador –newname $l.hostname
       Write-Host "foi"
    }
}


net use L: /delete






