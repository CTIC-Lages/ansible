## Compara o endereço mac e seta o nome de máquina

$list= Import-Csv \\acad02.lages.ifsc.edu.br\AcessoLivre\bruno\dados.csv

$list.GetType()


$mac  = Get-WmiObject win32_networkadapterconfiguration | select IPAddress, macaddress |
where-object{$_.IPAddress -match "10.151*" -and $_.macaddress -match "2c:76*" }
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



