$ServerWSUS = 'srv-wsus.csm.nov.ru'
$PortNumber = '8530'
$wsus = Get-WsusServer -Name $ServerWSUS -PortNumber $PortNumber
$ComputerNameTarget = $wsus | Get-WsusComputer -IncludedInstallationStates Failed -ComputerUpdateStatus Failed
$ComputerName = $ComputerNameTarget.FullDomainName
$Scriptblock = { Get-ChildItem -Path C:\Windows\SoftwareDistribution | Remove-Item -Recurse -Force }
Invoke-Command -Computer $ComputerName -ScriptBlock $Scriptblock