## Compara o endereço mac e seta o nome de máquina

$list= Import-Csv \\acad02.lages.ifsc.edu.br\AcessoLivre\bruno\dados.csv

$list.GetType()


$mac  = Get-WmiObject win32_networkadapterconfiguration | select IPAddress, macaddress |
where-object{$_.IPAddress -match "10.151*" -and ($_.macaddress -match "2c:76*" -or $_.macaddress -match "E4:11*" -or  $_.macaddress -match "84:34*" -or $_.macaddress -match "B4:B5*" -or  $_.macaddress -match "38:EA*" -or  $_.macaddress -match "AC:16*" -or  $_.macaddress -match "20:47*" -or  $_.macaddress -match "f4:8e*"  -or $_.macaddress -match "50:b3*" -or $_.macaddress -match "84:2B*" -or $_.macaddress -match "D0:94*")
 }

$mac.macaddress
$mac.IPAddress = [string]$mac.IPAddress
Write-Host "--------------------------"

foreach($l in $list){
    if ($l.MACADDRESS -eq $mac.macaddress){
      $nomeComputador = $env:computername
      $newRow = New-Object PsObject -Property @{MACADDRESS = $mac.macaddress; IP =  $mac.IPAddress; HOSTNAME =$nomeComputador }
     
      Export-Csv \\acad02.lages.ifsc.edu.br\AcessoLivre\bruno\teste.csv -inputobject $newRow -append -Force
      
      RENAME-COMPUTER –computername $nomeComputador –newname $l.hostname
      # Write-Host "foi"
    }
}


